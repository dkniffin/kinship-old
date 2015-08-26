class User < ActiveRecord::Base
  ROLES = [ROLE_UNAPPROVED = 'unauthorized',
           ROLE_MEMBER = 'member', # Read-only
           ROLE_EDITOR = 'editor',
           ROLE_ADMIN = 'admin']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :person

  before_validation :default_role_unapproved
  validates :email, :presence => true, :email => true
  validates :role, presence: true, inclusion: {in: ROLES}

  # Return whether or not the user is authorized at the given level of
  # permission
  def authorized?(level)
    # TODO: roles should probably be refactored into their own class
    rank = {
      ROLE_UNAPPROVED => 0,
      ROLE_MEMBER	    => 1,
      ROLE_EDITOR	    => 2,
      ROLE_ADMIN	    => 3
    }
    rank[role] >= rank[level]
  end

  def self.role_from_string(string)
    case string
    when 'unapproved'
      ROLE_UNAPPROVED
    when 'member'
      ROLE_MEMBER
    when 'editor'
      ROLE_EDITOR
    when 'admin'
      ROLE_ADMIN
    end
  end

  def approved?
    authorized?(ROLE_MEMBER)
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  private
    def default_role_unapproved
      self.role = User::ROLE_UNAPPROVED if self.role.nil?
    end
end
