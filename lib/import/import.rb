#!/usr/bin/ruby

require_relative 'gedcom-ruby/lib/gedcom.rb'
require 'pp'

class Import < GEDCOM::Parser
   def initialize
      super

      before  [ "INDI" ], method( :startPerson )
      before  [ "INDI", "NAME" ], method( :registerName )
      before  [ "INDI", "SEX" ], method( :registerGender )
      before  [ "INDI", "BIRT", "DATE" ], method( :registerBirthdate )
      #before  [ "INDI", "BIRT", "PLAC" ], method( :registerBirthplace )
      before  [ "INDI", "DEAT", "DATE" ], method( :registerDeathdate )
      #before  [ "INDI", "DEAT", "PLAC" ], method( :registerDeathplace )
      after [ "INDI" ], method( :endPerson )

      @currentPerson = nil
      @currentId = nil
      @allPeople = {}

   end
   def startPerson( data )
      if @opts[:v] >= 2
         puts "Creating new person"
      end
      @currentPerson = Person.create
      @currentId = data
   end

   def registerName( data )
      if @opts[:v] >= 2
         puts "Updating person's name: #{data}"
      end
      first_name, last_name  = data.split(/\//)
      first_name = '' if first_name.nil?
      last_name = '' if last_name.nil?

      @currentPerson.first_name = first_name.rstrip
      @currentPerson.last_name = last_name.rstrip
   end

   def registerGender( data )
      if @opts[:v] >= 3
         puts "updating person's gender: #{data}"
      end
      gender = data || ''
      @currentPerson.gender = gender unless (data.nil? || data.empty?)
   end

   def registerBirthdate( data )
      if @opts[:v] >= 3
         puts "updating person's birthdate: #{data}"
      end
      @currentPerson.birth.date = data unless (data.nil? || data.empty?)
   end

   def registerBirthplace( data )
      if @opts[:v] >= 3
         puts "updating person's birthplace: #{data}"
      end
      @currentPerson.birth.place.place_string = data unless (data.nil? || data.empty?)
   end

   def registerDeathdate( data )
      if @opts[:v] >= 3
         puts "updating person's deathdate #{data}"
      end
      @currentPerson.death.date = data unless (data.nil? || data.empty?)
   end

   def registerDeathplace( data )
      if @opts[:v] >= 3
         puts "updating person's deathplace #{data}"
      end
      @currentPerson.death.place.place_string = data unless (data.nil? || data.empty?)
   end

   def endPerson( data )
      @allPeople[@currentId] = @currentPerson
      if @opts[:v] >= 1
         puts "saving #{@currentPerson.full_name}"
      end
      if ! @currentPerson.death.date.nil? || ! @currentPerson.death.place.empty?
         @currentPerson.death.dead = true
      end
      @currentPerson.save!
      @currentPerson = nil
   end

   def printPeople
      pp @allPeople
   end
end
