class AddObjnameToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :objname, :string
  end
end
