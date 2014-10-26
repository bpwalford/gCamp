class Task < ActiveRecord::Base

  validates :description, presence: true
  validates :due_date, presence: true

  def due_soon
    Date.today >= self.due_date - 7.days ? true : false
  end

end
