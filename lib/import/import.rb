#!/usr/bin/ruby

require_relative 'gedcom-ruby/lib/gedcom.rb'

class Person
   attr_accessor :name, :gender, :bdate, :bplace, :ddate, :dplace

   def to_s
      "#{name} (#{gender}) B: #{bdate} at #{bplace}, D: #{ddate} at #{dplace}"
   end
end

class Import < GEDCOM::Parser
   def initialize
      super

      setPreHandler  [ "INDI" ], method( :startPerson )
      setPreHandler  [ "INDI", "NAME" ], method( :registerName )
      setPreHandler  [ "INDI", "SEX" ], method( :registerGender )
      setPreHandler  [ "INDI", "BIRT", "DATE" ], method( :registerBirthdate )
      setPreHandler  [ "INDI", "BIRT", "PLAC" ], method( :registerBirthplace )
      setPreHandler  [ "INDI", "DEAT", "DATE" ], method( :registerDeathdate )
      setPreHandler  [ "INDI", "DEAT", "PLAC" ], method( :registerDeathplace )
      setPostHandler [ "INDI" ], method( :endPerson )

      @currentPerson = nil
      @allPeople = []

   end
   def startPerson( data, state, parm )
      @currentPerson = Person.new
   end

   def registerName( data, state, parm )
      @currentPerson.name = data if @currentPerson.name == nil
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
      @currentPerson = nil
   end

   def printPeople
      @allPeople.each do |person|
         puts person.to_s
      end
   end
end

i = Import.new

i.parse("/home/kniffin/Kniffin.ged")
i.printPeople