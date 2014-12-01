class User < ActiveRecord::Base

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true, uniqueness: :true

  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def owner?(project)
    @membership = self.memberships.find_by(project: project)
    @membership.status != 'owner' ? false : true
  end

end
