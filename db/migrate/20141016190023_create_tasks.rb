class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :desription

      t.timestamps
    end
  end
end
