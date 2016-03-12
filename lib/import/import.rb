#!/usr/bin/ruby

require 'gedcom_ruby'
require 'pp'

class Import < GEDCOM::Parser
   def after_initialize
      @currentId = nil

      # Individuals
      before(["INDI"], :startPerson)
      before(["INDI", "NAME"], :registerName)
      before(["INDI", "SEX"], :registerGender)
      before(["INDI", "BIRT", "DATE"], :registerBirthdate)
      before(["INDI", "DEAT", "DATE"], :registerDeathdate)
      after(["INDI"], :endPerson)

      @currentPerson = nil
      @allPeople = {}

      # Families
      before ["FAM"], method(:startFamily)
      before ["FAM", "HUSB"], method(:registerHusband)
      before ["FAM", "WIFE"], method(:registerWife)
      before ["FAM", "CHIL"], method(:registerChild)
      after ["FAM"], method(:endFamily)

      @currentFamily = nil

      default_verbosity = 1
      @verbosity = @opts[:verbosity] || default_verbosity

      total_lines = @opts[:total_lines] || 0
      @dot_increment = 10
      @dot_counter = 0
   end

   ######################################################################
   # People
   ######################################################################

   def startPerson(data)
      if @verbosity >= 2
         puts "Creating new person"
      end
      @currentPerson = Person.create
      @currentId = data
   end

   def registerName(data)
      if @verbosity >= 2
         puts "Updating person's name: #{data}"
      end
      first_name, last_name  = data.split(/\//)
      first_name = '' if first_name.nil?
      last_name = '' if last_name.nil?

      @currentPerson.first_name = first_name.rstrip
      @currentPerson.last_name = last_name.rstrip
   end

   def registerGender(data)
      if @verbosity >= 3
         puts "updating person's gender: #{data}"
      end
      gender = data || ''
      @currentPerson.gender = gender unless (data.nil? || data.empty?)
   end

   def registerBirthdate(data)
      if @verbosity >= 3
         puts "updating person's birthdate: #{data}"
      end
      @currentPerson.birth.date = data unless (data.nil? || data.empty?)
   end

   def registerBirthplace(data)
      if @verbosity >= 3
         puts "updating person's birthplace: #{data}"
      end
      @currentPerson.birth.place.place_string = data unless (data.nil? || data.empty?)
   end

   def registerDeathdate(data)
      if @verbosity >= 3
         puts "updating person's deathdate #{data}"
      end
      @currentPerson.death.date = data unless (data.nil? || data.empty?)
   end

   def registerDeathplace(data)
      if @verbosity >= 3
         puts "updating person's deathplace #{data}"
      end
      @currentPerson.death.place.place_string = data unless (data.nil? || data.empty?)
   end

   def endPerson(data)
      @allPeople[@currentId] = @currentPerson
      if @verbosity >= 2
         puts "saving #{@currentPerson.full_name}"
      end
      if ! @currentPerson.death.date.nil? || ! @currentPerson.death.place.empty?
         @currentPerson.death.dead = true
      end
      @currentPerson.save!
      @currentPerson = nil
      @currentId = nil

      dot_handler
   end

   ######################################################################
   # Families
   ######################################################################

   def startFamily(data)
      if @verbosity >= 2
         puts "Starting new family"
      end
      @currentFamily = {
         :husband => nil,
         :wife => nil,
         :children => []
      }
      @currentId = data
   end

   def registerHusband(data)
      @currentFamily[:husband] = data
   end
   def registerWife(data)
      @currentFamily[:wife] = data
   end
   def registerChild(data)
      @currentFamily[:children].push data
   end

   def endFamily(data)
      if @verbosity >= 2
         puts "Processing family"
      end

      husb = @allPeople[@currentFamily[:husband]]
      wife = @allPeople[@currentFamily[:wife]]
      children = []
      @currentFamily[:children].each do |child_id|
         child = @allPeople[child_id]
         if !husb.nil?
            child.birth.parent_1_id = husb.id
         end
         if !wife.nil?
            child.birth.parent_2_id = wife.id
         end
         child.save!(validate: false)
      end

      @currentFamily = nil
      @currentId = nil

      dot_handler
   end

   def printPeople
      pp @allPeople
   end

   private
   def dot_handler
     if @dot_counter % @dot_increment == 0
       print '.'
     end
     @dot_counter += 1
   end
end
