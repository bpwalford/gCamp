class FixTaskColumnName < ActiveRecord::Migration
  def change
    rename_column :tasks, :desription, :description
  end
end
