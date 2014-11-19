class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates_uniqueness_of :user, message: 'has already been added'

  belongs_to :user
  belongs_to :project

end
