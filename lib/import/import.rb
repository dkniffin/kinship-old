#!/usr/bin/ruby

require_relative 'gedcom-ruby/lib/gedcom.rb'

class Import < GEDCOM::Parser
   def initialize(verbosity)
      super

      opts = { :v => verbosity }

      setPreHandler  [ "INDI" ], method( :startPerson ), opts
      setPreHandler  [ "INDI", "NAME" ], method( :registerName ), opts
      setPreHandler  [ "INDI", "SEX" ], method( :registerGender ), opts
      #setPreHandler  [ "INDI", "BIRT", "DATE" ], method( :registerBirthdate ), opts
      #setPreHandler  [ "INDI", "BIRT", "PLAC" ], method( :registerBirthplace ), opts
      #setPreHandler  [ "INDI", "DEAT", "DATE" ], method( :registerDeathdate ), opts
      #setPreHandler  [ "INDI", "DEAT", "PLAC" ], method( :registerDeathplace ), opts
      setPostHandler [ "INDI" ], method( :endPerson ), opts

      @currentPerson = nil
      @allPeople = []

   end
   def startPerson( data, state, parm )
      if parm[:v] >= 2
         puts "starting new person"
      end
      @currentPerson = Person.new

   end

   def registerName( data, state, parm )
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

   def registerGender( data, state, parm )
      @currentPerson.gender = data if @currentPerson.gender == nil
   end

   def registerBirthdate( data, state, parm )
      @currentPerson.bdate = data if @currentPerson.bdate == nil
   end

   def registerBirthplace( data, state, parm )
      @currentPerson.bplace = data if @currentPerson.bplace == nil
   end

   def registerDeathdate( data, state, parm )
      @currentPerson.ddate = data if @currentPerson.ddate == nil
   end

   def registerDeathplace( data, state, parm )
      @currentPerson.dplace = data if @currentPerson.dplace == nil
   end

   def endPerson( data, state, parm )
      @allPeople.push @currentPerson
      if parm[:v] >= 1
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
