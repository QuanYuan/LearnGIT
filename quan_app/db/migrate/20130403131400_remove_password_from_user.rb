class RemovePasswordFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :add_password
  end

  def down
    add_column :users, :add_password, :string
  end
end
