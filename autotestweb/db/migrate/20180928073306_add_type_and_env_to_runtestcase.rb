class AddTypeAndEnvToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :type, :string
    add_column :runtestcases, :env, :string
  end
end
