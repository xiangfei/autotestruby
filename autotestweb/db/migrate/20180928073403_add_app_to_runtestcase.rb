class AddAppToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :app, :string
  end
end
