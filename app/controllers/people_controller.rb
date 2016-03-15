class PeopleController < ApplicationController
  include PeopleHelper
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user

  decorates_assigned :people
  decorates_assigned :person

  def index
    # Get people
    @people = Person.filter(params[:query]).order(params[:sort]).page(params[:page])

    respond_with(@people)
  end

  def show
    @person = Person.find(params[:id])
    respond_with(@person)

    @json_pedigree_tree = get_json_pedigree_tree(@person)
  end

  def new
    @person = Person.new
    @child_id = params[:child_id]
    respond_with(@person)
  end

  def edit
  end

  def create
    @person = Person.create(person_params)
    if @person.errors.empty? && params[:child_id].present?
      Person.find(params[:child_id]).birth.add_parent(@person)
    end
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

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params
      .require(:person)
      .permit(
        :first_name,
        :last_name,
        :gender,
        :spouse_id,
        :photo,
        birth_attributes: [
          :id,
          :date,
          { place_attributes: [:id, :place_string] },
          :father_id,
          :mother_id
        ],
        death_attributes: [
          :id,
          :dead,
          { place_attributes: [:id, :place_string] },
          :date,
          :cause
        ]
      )
  end
end
