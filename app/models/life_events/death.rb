class Death < LifeEvent
   hstore_accessor :other_attributes,
    dead: :boolean,
    cause: :string

   before_save :build_default_place

   before_validation :dead_if_date

   validates :dead, inclusion: { in: [true] }, if: "!date.nil?"

   belongs_to :place, :autosave => true
   accepts_nested_attributes_for :place
   validates_associated :place

   def short_description
      if self.cause
         person.full_name + ' died' + " (cause: #{self.cause})"
      else
         person.full_name + ' died'
      end
   end

   def cause_string
      (cause.nil?) ? 'Unknown cause' : cause
   end

   def title_string
      'Death'
   end

   def details
      [
         'Date: ' + date_string,
         'Place: ' + place.place_string,
         'Cause: ' + cause_string
      ]
   end
   def date=(value)
      self.dead = true
      self[:date] = value
   end

   def icon_class
      'icon-cemetery'
   end

   private
      def dead_if_date
         if !date.nil?
            dead = true
         end
      end
      def build_default_place
         build_place if place.nil?
      end
end