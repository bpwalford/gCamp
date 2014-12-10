class User < ActiveRecord::Base

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true, uniqueness: :true

  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  before_save :token_nil_if_bank

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def token_nil_if_bank
    self.tracker_token = nil if self.tracker_token.blank?
  end

  def owner?(project)
    unless admin?
      @membership = self.memberships.find_by(project: project)
      @membership.status != 'owner' ? false : true
    end
  end

end
