class AddMailtoToDelaytask < ActiveRecord::Migration[5.2]
  def change
    add_column :delaytasks, :mailto, :string
  end
end
