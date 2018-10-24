class AddModelclassToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :modelclass, :string
  end
end
