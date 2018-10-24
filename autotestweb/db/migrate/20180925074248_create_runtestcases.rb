class CreateRuntestcases < ActiveRecord::Migration[5.2]
  def change
    create_table :runtestcases do |t|
      t.string :server
      t.string :folder

      t.timestamps
    end
  end
end
