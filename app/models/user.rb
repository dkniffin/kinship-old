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

  def rank(role)
  end

  # Return whether or not the user is authorized at the given level of
  # permission
  def authorized?(level)
    # TODO: roles should probably be refactored into their own class
    rank = {
      User::ROLE_UNAPPROVED => 0,
      User::ROLE_MEMBER	    => 1,
      User::ROLE_EDITOR	    => 2,
      User::ROLE_ADMIN	    => 3
    }
    rank[role] >= rank[level]
  end

  private
    def default_role_unapproved
      self.role = User::ROLE_UNAPPROVED if self.role.nil?
    end
end
