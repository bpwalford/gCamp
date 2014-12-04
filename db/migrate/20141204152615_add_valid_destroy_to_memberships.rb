class AddValidDestroyToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :valid_destroy, :boolean, default: false
  end
end
