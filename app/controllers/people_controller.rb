class PeopleController < ApplicationController
  include PeopleHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user
  # GET /people
  # GET /people.json
  def index
    # Get people
    @genders = params[:genders].nil? ? Person.all_genders : params[:genders].keys
    @people = Person.gender(@genders).filter(params[:query]).order(params[:sort]).page(params[:page])

    # Get genders
    @all_genders = Person.all_genders
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    @eventsFormat = Setting.eventsFormat
    @children = @person.children
    if @person.spouse_id
       @spouse = Person.find(@person.spouse_id)
    end

    @primary_siblings = @person.siblings
    @half_siblings = @person.siblings(:half)
    @json_pedigree_tree = get_json_pedigree_tree(@person)

  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if  @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
    # Clear the record of the person in Birth
    Birth.where(:father_id => @person.id).each do |child|
      child.father_id = nil
      child.save
    end
    Birth.where(:mother_id => @person.id).each do |child|
      child.mother_id = nil
      child.save
    end
  end

  def stats
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
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :gender, :spouse_id, :photo,
        birth_attributes: [:id, :date, {place_attributes: [:id, :place_string]}, :father_id, :mother_id],
        death_attributes: [:id, :dead, {place_attributes: [:id, :place_string]}, :date, :cause]
      )
    end
end
