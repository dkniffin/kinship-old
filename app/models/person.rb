class Person < ActiveRecord::Base
  before_validation :default_values
  before_create :build_default_birth, :build_default_death

  # Photo stuff
  has_attached_file :photo,
    :styles => { :medium => "256x256#", :small => "64x64#", :tiny => "24x24#" },
    :default_url => :set_default_avatar,
    :url  => "/assets/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  # Birth
  has_one :birth, class_name: "LifeEvent::Birth", foreign_key: "child_id"
  accepts_nested_attributes_for :birth
  validates_associated :birth

  # Death
  has_one :death, class_name: "LifeEvent::Death"
  accepts_nested_attributes_for :death
  validates_associated :death

  # User
  has_one :user

  # Other Validations
  # Allow blank values; see private method default_values for details
  validates :first_name, :presence => true, :allow_blank => true
  validates :last_name, :presence => true, :allow_blank => true
  validates :spouse_id, :presence => true, :allow_blank => true

  VALID_GENDERS = ['M', 'F']
  MALE = 'M'
  FEMALE = 'F'
  validates :gender, :presence => true, inclusion: {in: VALID_GENDERS}, :allow_blank => true

  scope :gender, ->(genders = VALID_GENDERS) { where(gender: genders) }
  scope :filter, ->(query) { where('first_name LIKE ? OR last_name LIKE ?', "%#{query}%", "%#{query}%") }
  scope :with_name, ->(name) { where('first_name || " " || last_name = ?', name) }

  def parents
    birth.parents
  end

  def father
    birth.father
  end

  def mother
    birth.mother
  end

  def parent_births
    LifeEvent::Birth.with_parent(self)
  end

  def marriages
    LifeEvent::Marriage.with_person(self)
  end

  def spouses
    LifeEvent::Marriage.with_person(self).map { |m| m.spouse_of(self) }.flatten
  end

  def children
    parent_births.map(&:child)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def alive?
    !death.dead
  end

  def age(date = Time.zone.today)
    return nil if birth.date.nil?

    age = date - birth.date.year
    age -= 1 if date < birth.date + age.years
    age
  end

  def siblings(mod = :all)
    case mod
    when :all
      parents.map{|p| p.children }.flatten.uniq - [self]
    when :step
      [] # TODO: step_parents.children
    when :half
      siblings(:all) - siblings(:full)
    when :full
      siblings(:all).select{|s| s.parents == self.parents}
    end
  end

  def events
    e = []

    e.push(birth)
    e.push(marriages)
    e.push(death)

    # TODO: Add sibling births and deaths
    # TODO: Add child births and deaths
    # TODO: Add parent births and deaths
    # TODO: Add spouse births and deaths

    e.flatten
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
      build_birth if birth.nil?
    end

    def build_default_death
      build_death if death.nil?
    end

    def set_default_avatar
      if gender == "F"
        default_avatar = "/assets/default_:style_female_avatar.png"
      else
        default_avatar = "/assets/default_:style_male_avatar.png"
      end
    end
end
