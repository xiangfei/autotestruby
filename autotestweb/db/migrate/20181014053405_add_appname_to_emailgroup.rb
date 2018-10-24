class AddAppnameToEmailgroup < ActiveRecord::Migration[5.2]
  def change
    add_column :emailgroups, :appname, :string
  end
end
