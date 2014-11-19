class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates_uniqueness_of :user

  belongs_to :user
  belongs_to :project

end
