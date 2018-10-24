class AddDescriptionToServer < ActiveRecord::Migration[5.2]
  def change
    add_column :servers, :description, :string
  end
end
