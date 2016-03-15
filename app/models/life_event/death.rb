module LifeEvent
  class Death < ActiveRecord::Base
    before_save :build_default_place

    validate :date_in_past

    belongs_to :person
    has_one :place, as: :locatable
    accepts_nested_attributes_for :place
    validates_associated :place

    has_many :references, as: :referenceable
    has_many :sources, through: :references
    accepts_nested_attributes_for :references

    def date=(value)
      self[:date] = value
    end

    private

    def build_default_place
      build_place if place.nil?
    end

    def date_in_past
      errors.add(:date, "must be in the past") if date.present? && date >= Date.today
    end
  end
end
