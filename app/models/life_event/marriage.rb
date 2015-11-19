module LifeEvent
  class Marriage < ActiveRecord::Base
    before_save :build_default_place

    belongs_to :person_1, class_name: "Person", foreign_key: "person_1_id"
    belongs_to :person_2, class_name: "Person", foreign_key: "person_2_id"

    accepts_nested_attributes_for :person_1
    accepts_nested_attributes_for :person_2

    scope :with_person, ->(person) do
      where("person_1_id = :person_id OR person_2_id = :person_id",
        person_id: person.id)
    end

    has_one :place, as: :locatable
    accepts_nested_attributes_for :place
    validates_associated :place

    validates :person_1, :person_2, presence: true

    # TODO: abstract this out to a decorator class
    def date_string
      (date.nil?) ? 'Unknown date' : date.formatted
    end

    def build_default_place
      build_place if place.nil?
    end

    def spouse_ids
      [person_1_id, person_2_id]
    end

    def spouses
      Person.where(id: spouse_ids)
    end

    def spouse_of(person)
      raise "person not in marriage" unless spouse_ids.include?(person.id)
      spouse_id = spouse_ids - [person.id]
      Person.where(id: spouse_id).first
    end

    def event_name
      "The marriage between #{person_1.full_name} and #{person_2.full_name}"
    end

    def short_description
      "#{person_1.full_name} married #{person_2.full_name}"
    end

    def icon_class
      'icon-rings'
    end
  end
end
