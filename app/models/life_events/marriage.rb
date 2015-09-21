class Marriage < ActiveRecord::Base
  before_save :build_default_place

  belongs_to :person_1, class_name: "Person", foreign_key: "person_1_id"
  belongs_to :person_2, class_name: "Person", foreign_key: "person_2_id"

  scope :with_person, ->(person) { where("person_1_id = :person_id OR person_2_id = :person_id", person_id: person.id) }

  has_one :place, as: :locatable
  accepts_nested_attributes_for :place
  validates_associated :place

  # TODO: abstract this out to a decorator class
  def date_string
    (date.nil?) ? 'Unknown date' : date.formatted
  end

  def build_default_place
    build_place if place.nil?
  end
end
