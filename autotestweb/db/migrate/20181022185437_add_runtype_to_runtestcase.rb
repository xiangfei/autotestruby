class AddRuntypeToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :runtype, :string
  end
end
