class AddUserToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :user, :string
  end
end
