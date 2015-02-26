class Person < ActiveRecord::Base
   before_validation :default_values
   after_create :build_default_birth, :build_default_death

   # Photo stuff
   has_attached_file :photo,
      :styles => { :medium => "256x256#", :small => "64x64#", :tiny => "24x24#" },
      :default_url => :set_default_avatar,
      :url  => "/assets/photos/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
   validates_attachment_size :photo, :less_than => 5.megabytes
   validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

   # LifeEvents
   has_many :life_events
   has_one :birth, -> { where(type: "Birth") }, class_name: "LifeEvent"
   has_one :death, -> { where(type: "Death") }, class_name: "LifeEvent"

   # User
   has_one :user

   # Spouse

   # Other Validations
   # Allow blank values; see private method default_values for details
   validates :first_name, :presence => true, :allow_blank => true
   validates :last_name, :presence => true, :allow_blank => true
   validates :spouse_id, :presence => true, :allow_blank => true

   VALID_GENDERS = ['M', 'F']
   validates :gender, :presence => true, inclusion: {in: VALID_GENDERS},:allow_blank => true

   scope :gender, ->(genders = VALID_GENDERS) { where(gender: genders) }
   scope :filter, ->(query) { where('first_name LIKE ? OR last_name LIKE ?', "%#{query}%", "%#{query}%") }

   def father
      birth.father
   end
   def father=(p)
      birth.father = p
   end
   def mother
      birth.mother
   end
   def mother=(p)
      birth.mother = p
   end

   def full_name
      first_name + ' ' + last_name
   end

   def full_name_and_id
      first_name + ' ' + last_name + " \(#{id}\)"
   end

   def alive?
      return !death.dead
   end

   def children
      # TODO: Might be able to minimize the search here by basing it on gender
      children_ids = Birth.where("other_attributes -> 'father_id' = ?",id.to_s).map {|elt| elt.child_id}
      children_ids += Birth.where("other_attributes -> 'mother_id' = ?",id.to_s).map {|elt| elt.child_id}
      return Person.where(:id => children_ids)
   end

   def age(date=Date.today)
      return nil if birth.date.nil?

      if death.date
         date = death.date
      end

      diff = date - birth.date
      age = (diff / 365.25).floor
      age
   end

   def siblings(mod=:full)
      father_id = birth.father_id
      mother_id = birth.mother_id
      siblings = []
      sibling_ids = []

      # TODO: step siblings
      case mod
      when :full
         if !father_id.nil? and !mother_id.nil?
            sibling_ids = Birth.where(:father_id => father_id,
                                    :mother_id => mother_id).map {|elt| elt.child_id} - [id]
         end
      when :half
         father_sibling_ids=[]
         mother_sibling_ids=[]
         if !father_id.nil?
            father_sibling_ids = Birth.where(:father_id => father_id)
         end
         if !mother_id.nil?
            mother_sibling_ids = Birth.where(:mother_id => mother_id)
         end

         # One parent is the same (father_children xor mother_children)
         sibling_ids = father_sibling_ids + mother_sibling_ids - (father_sibling_ids & mother_sibling_ids)
      else
         raise "Unknown sibling type"
      end

      return siblings = Person.where(:id => sibling_ids)
   end

   def events
      e = []

      if !birth.nil?
         e.push(birth)
      end
      if death.dead
         e.push(death)
      end
      # TODO: Add sibling births and deaths
      # TODO: Add child births and deaths
      # TODO: Add parent births and deaths
      # TODO: Add spouse births and deaths

      return e
   end

   def markers
      event_markers = []

      events.each do |event|
         if event.place.has_valid_latlng?
            event_markers.push({
               :latlng => [event.place.lat, event.place.lon],
               :title => event.title_string,
               :place => event.place.place_string,
               :date => event.date_string
            })
         end
      end
      event_markers
   end

   def self.all_genders
      VALID_GENDERS
   end

   private
      def default_values
         # These values might not be known when we build the user, but we
         # still want them to have a value, so we'll set them to blank

         # Some examples where we might not know this information:
         #  We want to add a father, because we know where he was born, but
         #  we don't know his name.
         #  We know someone has a sibling, but we don't know their gender
         self.first_name ||= ''
         self.last_name ||= ''
         self.gender ||= ''
         self.spouse_id ||= ''
      end
      def build_default_birth
         birth = Birth.create if birth.nil?
         life_events << birth
      end
      def build_default_death
         death = Death.create if death.nil?
         life_events << death
      end
    def set_default_avatar
      if gender == "F"
        default_avatar = "/assets/default_:style_female_avatar.png"
      else
        default_avatar = "/assets/default_:style_male_avatar.png"
      end
    end
end
