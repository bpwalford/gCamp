class Task < ActiveRecord::Base

  validates :description, presence: true
  validates :due_date, presence: true

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
