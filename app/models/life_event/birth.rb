module LifeEvent
  class Birth < ActiveRecord::Base
    before_save :build_default_place

    belongs_to :child, class_name: "Person", foreign_key: "child_id"
    belongs_to :parent_1, class_name: "Person", foreign_key: "parent_1_id"
    belongs_to :parent_2, class_name: "Person", foreign_key: "parent_2_id"

    scope :with_parent, ->(parent) { where("parent_1_id = :parent_id OR births.parent_2_id = :parent_id", parent_id: parent.id) }

    has_one :place, as: :locatable
    accepts_nested_attributes_for :place
    validates_associated :place

    #validate :parents_born_before_child
    validate :date_in_past

    has_many :references, as: :referenceable
    has_many :sources, through: :references
    accepts_nested_attributes_for :references

    def parents
      [parent_1, parent_2].compact
    end

    def father
      parents.select{ |p| p.gender == Person::MALE }.first
    end

    def mother
      parents.select{ |p| p.gender == Person::FEMALE }.first
    end

    def remove_parent(parent)
      if birth.parent_1_id == parent.id
        birth.update(parent_1_id: nil)
      elsif birth.parent_2_id == parent.id
        birth.update(parent_2_id: nil)
      end
    end

    private

      def parents_born_before_child
        ## TODO: Might want to add a setting to check that it's at least a
        ## certain number of years before
        if father.present? && father.birth.date.present? &&
          date.present? && father.birth.date >= date
            errors.add(:father, "can't be born before child")
        end
        if mother.present? && mother.birth.date.present? &&
          date.present? && mother.birth.date >= date
            errors.add(:mother, "can't be born before child")
        end
      end

      def build_default_place
        build_place if place.nil?
      end

      def date_in_past
        if date.present? and date >= Date.today
          errors.add(:date, "must be in the past")
        end
      end
  end
end
