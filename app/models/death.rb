class Death < ActiveRecord::Base
   before_save :build_default_place

   before_validation :dead_if_date

   validates :dead, inclusion: { in: [true] }, if: "!date.nil?"
   validate :date_in_past

   belongs_to :person
   has_one :place, as: :locatable
   accepts_nested_attributes_for :place
   validates_associated :place

   def short_description
      if self.cause
         person.full_name + ' died' + " (cause: #{self.cause})"
      else
         person.full_name + ' died'
      end
   end

   def date_string
      (date.nil?) ? 'Unknown date' : date.formatted
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
      def date_in_past
         errors.add(:date, "must be in the past") if
            date.present? and date >= Date.today
      end
end
