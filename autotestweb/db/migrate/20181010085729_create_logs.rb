class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :controller
      t.string :action
      t.string :user
      t.text :params
      t.integer :objid
      t.string :method

      t.timestamps
    end
  end
end
