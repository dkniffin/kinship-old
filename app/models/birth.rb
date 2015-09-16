class Birth < ActiveRecord::Base
   before_save :build_default_place

   belongs_to :child, :class_name => "Person"

   belongs_to :place, :autosave => true
   accepts_nested_attributes_for :place
   validates_associated :place

   validate :parents_born_before_child
   validate :date_in_past

   def father
      if father_id
         Person.find(father_id)
      else
         nil
      end
   end

   def mother
      if mother_id
         Person.find(mother_id)
      else
         nil
      end
   end

   def parents_string
      mother_str = (mother.nil?) ? 'Unknown mother' : mother.full_name
      father_str = (father.nil?) ? 'Unknown father' : father.full_name
      mother_str + ' and ' + father_str
   end

   def date_string
      (date.nil?) ? 'Unknown date' : date.formatted
   end

   def short_description
      child.full_name + ' was born'
   end

   def title_string
      'Birth'
   end

   def details
      [
         'Parents: ' + parents_string,
         'Date: ' + date_string,
         'Place: ' + place.place_string
      ]
   end

   def icon_class
      'icon-baby'
   end

   private

      def parents_born_before_child
         ## TODO: Might want to add a setting to check that it's at least a
         ## certain number of years before
         if father.present? &&
            father.birth.date.present? &&
            date.present? &&
            father.birth.date >= date
            errors.add(:father, "can't be born before child")
         end
         if mother.present? &&
            mother.birth.date.present? &&
            date.present? &&
            mother.birth.date >= date
            errors.add(:mother, "can't be born before child")
         end
      end
      def build_default_place
         build_place if place.nil?
      end
      def date_in_past
         errors.add(:date, "must be in the past") if
            date.present? and date >= Date.today
      end
end
