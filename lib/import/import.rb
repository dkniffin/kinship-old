#!/usr/bin/ruby

require 'gedcom_ruby'
require 'pp'

class Import < GEDCOM::Parser

  # During initialization, #after_initialize gets called, which calls sets up listeners for all the
  # methods below it. Then, when the #parse method gets called, it broadcasts to the listeners

  private

  def after_initialize
    @current_id = nil

    # Individuals
    before %w(INDI), :start_person
    before %w(INDI NAME), :register_name
    before %w(INDI SEX), :register_gender
    before %w(INDI BIRT DATE), :register_birth_date
    before %w(INDI DEAT DATE), :register_death_date
    after %w(INDI), :end_person

    @current_person = nil
    @all_people = {}

    # Families
    before %w(FAM), method(:start_family)
    before %w(FAM HUSB), method(:register_husband)
    before %w(FAM WIFE), method(:register_wife)
    before %w(FAM CHIL), method(:register_child)
    after %w(FAM), method(:end_family)

    @current_family = nil

    default_verbosity = 1
    @verbosity = @opts[:verbosity] || default_verbosity

    # total_lines = @opts[:total_lines] || 0
    @dot_increment = 10
    @dot_counter = 0
  end

  ######################################################################
  # People
  ######################################################################

  def start_person(data)
    if @verbosity >= 2
      puts "Creating new person"
    end
    @current_person = Person.create
    @current_id = data
  end

  def register_name(data)
    if @verbosity >= 2
      puts "Updating person's name: #{data}"
    end
    first_name, last_name = data.split(%r(/))
    first_name = '' if first_name.nil?
    last_name = '' if last_name.nil?

    @current_person.first_name = first_name.rstrip
    @current_person.last_name = last_name.rstrip
  end

  def register_gender(data)
    if @verbosity >= 3
      puts "updating person's gender: #{data}"
    end
    gender = data || ''
    @current_person.gender = gender unless data.nil? || data.empty?
  end

  def register_birth_date(data)
    if @verbosity >= 3
      puts "updating person's birthdate: #{data}"
    end
    @current_person.birth.date = data unless data.nil? || data.empty?
  end

  def register_death_date(data)
    if @verbosity >= 3
      puts "updating person's deathdate #{data}"
    end
    @current_person.death.date = data unless data.nil? || data.empty?
  end

  def end_person(_data)
    @all_people[@current_id] = @current_person
    if @verbosity >= 2
      puts "saving #{@current_person.full_name}"
    end
    if ! @current_person.death.date.nil? || ! @current_person.death.place.empty?
      @current_person.death.dead = true
    end
    @current_person.save!
    @current_person = nil
    @current_id = nil

    dot_handler
  end

  ######################################################################
  # Families
  ######################################################################

  def start_family(data)
    if @verbosity >= 2
      puts "Starting new family"
    end
    @current_family = {
      husband: nil,
      wife: nil,
      children: []
    }
    @current_id = data
  end

  def register_husband(data)
    @current_family[:husband] = data
  end

  def register_wife(data)
    @current_family[:wife] = data
  end

  def register_child(data)
    @current_family[:children].push data
  end

  def end_family(_data)
    if @verbosity >= 2
      puts "Processing family"
    end

    husb = @all_people[@current_family[:husband]]
    wife = @all_people[@current_family[:wife]]
    @current_family[:children].each do |child_id|
      child = @all_people[child_id]
      unless husb.nil?
        child.birth.parent_1_id = husb.id
      end
      unless wife.nil?
        child.birth.parent_2_id = wife.id
      end
      child.save!(validate: false)
    end

    @current_family = nil
    @current_id = nil

    dot_handler
  end

  def print_people
    pp @all_people
  end

  def dot_handler
    if @dot_counter % @dot_increment == 0
      print '.'
    end
    @dot_counter += 1
  end
end
