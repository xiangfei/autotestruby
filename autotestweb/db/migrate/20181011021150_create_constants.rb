class CreateConstants < ActiveRecord::Migration[5.2]
  def change
    create_table :constants do |t|
      t.string :name
      t.string :value
      t.string :scope

      t.timestamps
    end
  end
end
