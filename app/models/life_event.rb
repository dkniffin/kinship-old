class LifeEvent < ActiveRecord::Base
   validate :date_in_past

   belongs_to :person, :polymorphic => true

   def date_string
      (date.nil?) ? 'Unknown date' : date.formatted
   end

   def icon_class
      'icon-event'
   end

   private
      def date_in_past
         errors.add(:date, "must be in the past") if
            !date.blank? and date >= Date.today
      end
end
