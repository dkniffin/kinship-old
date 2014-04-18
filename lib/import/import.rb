#!/usr/bin/ruby

require_relative 'gedcom-ruby/lib/gedcom.rb'

class Import < GEDCOM::Parser
   def initialize
      super

      before  [ "INDI" ], method( :startPerson )
      before  [ "INDI", "NAME" ], method( :registerName )
      before  [ "INDI", "SEX" ], method( :registerGender )
      before  [ "INDI", "BIRT", "DATE" ], method( :registerBirthdate )
      before  [ "INDI", "BIRT", "PLAC" ], method( :registerBirthplace )
      #before  [ "INDI", "DEAT", "DATE" ], method( :registerDeathdate )
      #before  [ "INDI", "DEAT", "PLAC" ], method( :registerDeathplace )
      after [ "INDI" ], method( :endPerson )

      @currentPerson = nil
      @allPeople = []

   end
   def startPerson( data )
      if @opts[:v] >= 2
         puts "Creating new person"
      end
      @currentPerson = Person.create

   end

   def registerName( data )
      (first_name, last_name ) = data.split("/")
      first_name = '' if first_name == nil
      last_name = '' if last_name == nil

      if @currentPerson.first_name == nil
         @currentPerson.first_name = first_name.rstrip
      end
      if @currentPerson.last_name == nil && last_name != nil
         @currentPerson.last_name = last_name.rstrip
      end
   end

   def registerGender( data )
      if @opts[:v] >= 3
         puts "updating person's gender"
      end
      @currentPerson.gender = data if @currentPerson.gender == nil
   end

   def registerBirthdate( data )
      if @opts[:v] >= 3
         puts "updating person's birthdate"
      end
      @currentPerson.birth.date = data if @currentPerson.birth.date == nil
   end

   def registerBirthplace( data )
      if @opts[:v] >= 3
         puts "updating person's birthplace"
      end
      @currentPerson.birth.place = data if @currentPerson.birth.place == nil
   end

   def registerDeathdate( data )
      if @opts[:v] >= 3
         puts "updating person's deathdate"
      end
      @currentPerson.ddate = data if @currentPerson.ddate == nil
   end

   def registerDeathplace( data )
      if @opts[:v] >= 3
         puts "updating person's deathplace"
      end
      @currentPerson.dplace = data if @currentPerson.dplace == nil
   end

   def endPerson( data )
      @allPeople.push @currentPerson
      if @opts[:v] >= 1
         puts "saving #{@currentPerson.full_name}"
      end
      @currentPerson.save!
      @currentPerson = nil
   end

   def printPeople
      @allPeople.each do |person|
         puts person.full_name
      end
   end
end
