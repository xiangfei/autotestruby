class RenameTypeToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    rename_column :runtestcases, :type, :casetype
  end
end
