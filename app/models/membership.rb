class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates :user, uniqueness: {scope: :project, message: 'has already been added'}

  belongs_to :user
  belongs_to :project

  before_destroy :check_user_count

  def check_user_count
    if self.project.memberships.count < 2
      errors.add(:memberships, ", you must have one")
      false unless self.valid_destroy == true
    end
  end

end
