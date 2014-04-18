#!/usr/bin/ruby

require_relative 'gedcom-ruby/lib/gedcom.rb'

class Person
   attr_accessor :name, :gender, :bdate, :bplace, :ddate, :dplace

   def to_s
      "#{name}"
   end
end

class Import < GEDCOM::Parser
   def initialize
      super

      setPreHandler  [ "INDI" ], method( :startPerson )
      setPreHandler  [ "INDI", "NAME" ], method( :registerName )
      setPreHandler  [ "INDI", "BIRT", "DATE" ], method( :registerBirthdate )
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
   def registerBirthdate( data, state, parm )
      if @currentPerson.date == nil
         d = GEDCOM::Date.safe_new( data )
         if d.is_date? and d.first.has_year? and d.first.has_month?
            @currentPerson.date = d
         end
      end
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