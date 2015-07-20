class AddIndexToUsersEmail < ActiveRecord::Base
  def change
    add_index :users, :email, unique: true
  end
end
