class PeopleController < ApplicationController
  include PeopleHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user

  decorates_assigned :people
  decorates_assigned :person

  def index
    # Get people
    @people = Person.
      filter(params[:query]).
      order(params[:sort]).
      page(params[:page])

    respond_with(@people)
  end

  def show
    @person = Person.find(params[:id])
    respond_with(@person)

    @json_pedigree_tree = get_json_pedigree_tree(@person)
  end

  def new
    @person = Person.new
    respond_with(@person)
  end

  def edit
  end

  def create
    @person = Person.create(person_params)
    respond_with(@person)
  end

  def update
    @person.update(person_params)
    respond_with(@person)
  end

  def destroy
    # Clear the record of the person in Birth
    # TODO: Move this to a before_destroy
    @person.parent_births.each{ |birth| birth.remove_parent(@person) }
    @person.destroy

    respond_with(@person)
  end

  def stats
    # TODO: Refactor this entire method and move it elsewhere
    # Gender distribution
    @women = Person.where(:gender => 'F')
    @men = Person.where(:gender => 'M')

    # Average lifespan by century
    lifespan_total = Array.new(Date.today.century + 1, 0)
    @lifespan = Array.new(Date.today.century + 1, 0)
    @family_population_per_century = Array.new(Date.today.century + 1, 0)
    Person.all.each do |person|
      if person.death.date.nil?
        next
      elsif person.birth.date.nil?
        next
      else
        c = person.death.date.century
        lifespan_total[c] += person.age('death_date')
        @family_population_per_century[c] += 1
      end
    end

    lifespan_total.each_with_index do |total_lifespan, index|
      if @family_population_per_century[index] == 0
        next
      end
      @lifespan[index] = total_lifespan / @family_population_per_century[index]
    end

    # For surname word cloud
    surnameCount = {}
    Person.all.each{|person|
      surnameCount[person.last_name] = (surnameCount[person.last_name] || 0) + 1
    }

    @surname_word_data = []
    surnameCount.each{|key, value|
      @surname_word_data.push({key: key, value: value})
    }

    @surname_word_data = JSON.generate(@surname_word_data)
    # For first name word cloud
    first_nameCount = {}
    Person.all.each{|person|
      first_nameCount[person.first_name] = (first_nameCount[person.first_name] || 0) + 1
    }

    @first_name_word_data = []
    first_nameCount.each{|key, value|
      @first_name_word_data.push({key: key, value: value})
    }

    @first_name_word_data = JSON.generate(@first_name_word_data)
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :gender, :spouse_id, :photo,
      birth_attributes: [:id, :date, {place_attributes: [:id, :place_string]}, :father_id, :mother_id],
      death_attributes: [:id, :dead, {place_attributes: [:id, :place_string]}, :date, :cause]
    )
  end
end
