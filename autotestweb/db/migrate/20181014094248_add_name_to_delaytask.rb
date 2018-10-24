class AddNameToDelaytask < ActiveRecord::Migration[5.2]
  def change
    add_column :delaytasks, :name, :string
  end
end
