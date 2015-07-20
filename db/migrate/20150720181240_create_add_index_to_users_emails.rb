class CreateAddIndexToUsersEmails < ActiveRecord::Migration
  def change
    create_table :add_index_to_users_emails do |t|

      t.timestamps null: false
    end
  end
end
