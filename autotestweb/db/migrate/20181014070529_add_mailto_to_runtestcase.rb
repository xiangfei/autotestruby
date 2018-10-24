class AddMailtoToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :mailto, :string
  end
end
