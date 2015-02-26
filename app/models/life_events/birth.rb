class Birth < LifeEvent
   hstore_accessor :other_attributes,
    father_id: :integer,
    mother_id: :integer,
    child_id: :integer

   before_save :build_default_place

   belongs_to :place, :autosave => true
   accepts_nested_attributes_for :place
   validates_associated :place

   validate :parents_born_before_child

   belongs_to :father, :class_name => "Person", :foreign_key => :father_id
   belongs_to :mother, :class_name => "Person", :foreign_key => :mother_id
   belongs_to :person

   def parents_string
      mother_str = (mother.nil?) ? 'Unknown mother' : mother.full_name
      father_str = (father.nil?) ? 'Unknown father' : father.full_name
      mother_str + ' and ' + father_str
   end

   def short_description
      person.full_name + ' was born'
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
end
