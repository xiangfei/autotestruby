class AddDescriptionToApp < ActiveRecord::Migration[5.2]
  def change
    add_column :apps, :description, :string
  end
end
