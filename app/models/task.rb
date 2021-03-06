class Task < ActiveRecord::Base

  validates_presence_of :description, allow_blank: false
  validate :cant_be_due_in_past, on: :create

  belongs_to :project
  has_many :comments, dependent: :destroy


  def cant_be_due_in_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def due_soon
    if self.due_date
      Date.today >= self.due_date - 7.days ? true : false
    else
      false
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |task|
        csv << task.attributes.values_at(*column_names)
      end
    end
  end

end
