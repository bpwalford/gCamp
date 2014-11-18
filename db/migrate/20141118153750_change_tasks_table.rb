class ChangeTasksTable < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.belongs_to :projects
    end
  end
end
