class AddIndexToUsersEmail < ActiveRecord::Migration
#what matters is the add_index method, class name has nothing to do with adding index
  def change
    add_index :users, :email, unique: true
    #add index to resource user, index is email and it should be unique
  end
end
