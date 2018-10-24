class CreateEmailgroups < ActiveRecord::Migration[5.2]
  def change
    create_table :emailgroups do |t|
      t.string :name

      t.timestamps
    end
  end
end
