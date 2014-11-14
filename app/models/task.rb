class Task < ActiveRecord::Base

  validates_presence_of :description, :due_date
  validate :cant_be_due_in_past, on: :create


  def cant_be_due_in_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def due_soon
    Date.today >= self.due_date - 7.days ? true : false
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
