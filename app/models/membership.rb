class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates :user, uniqueness: {scope: :project, message: 'has already been added'}
  validate :member_or_owner

  belongs_to :user
  belongs_to :project

  before_destroy :check_user_count

  def check_user_count
    memberships = self.project.memberships.where(status: 'owner')
    if memberships.count < 2 && self.status == 'owner'
      errors.add(:projects, " must have one owner")
      false unless self.valid_destroy == true
    end
  end

  def member_or_owner
    unless self.status == 'member' || self.status == 'owner'
      errors.add(:membership, ' must be member or owners')
    end
  end

end
