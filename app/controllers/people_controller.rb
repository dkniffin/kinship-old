class PeopleController < ApplicationController
  include PeopleHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    query = params[:query]
    sort = params[:sort] || session[:sort]

    case sort
    when 'first_name'
      ordering,@first_name_header = {:order => :first_name}, 'hilite'
    when 'last_name'
      ordering,@last_name_header = {:order => :last_name}, 'hilite'
    end
    @all_genders = Person.all_genders
    @selected_genders = params[:genders] || {}

    if @selected_genders == {}
      @selected_genders = Hash[@all_genders.map {|gender| [gender, gender]}]
    end
    # Allow searching for people with no gender specified
    if @selected_genders.keys.include?('M') and @selected_genders.keys.include?('F')
       @selected_genders[' '] = "1"
    end

    if params[:sort] != session[:sort] or params[:genders] != session[:genders] or params[:query] != session[:query]
      session[:sort] = sort
      session[:genders] = @selected_genders
      session[:query] = query
      redirect_to :sort => sort, :genders => @selected_genders, :query => query and return
    end

    @search_genders = @selected_genders.keys << ''
    if query
       gender_results = Person.find_all_by_gender(@search_genders, ordering)
       people_results = Person.where('first_name NOT LIKE ? AND last_name NOT LIKE ?', "%#{query}%", "%#{query}%")
       @people = (gender_results - people_results).uniq
    else
      @people = Person.find_all_by_gender(@search_genders, ordering)
    end
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :gender, :photo, 
        birth_attributes: [:date, {place_attributes: [:place_string]}, :father_id, :mother_id], 
        death_attributes: [:dead, {place_attributes: [:place_string]}, :date, :place_id, :cause]
      )
    end
end
