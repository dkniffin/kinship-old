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

  private
    def default_role_unapproved
      self.role = User::ROLE_UNAPPROVED if self.role.nil?
    end
end
