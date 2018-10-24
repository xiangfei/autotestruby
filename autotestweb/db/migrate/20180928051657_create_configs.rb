class CreateConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :configs do |t|
      t.references :app, foreign_key: true
      t.string :name
      t.string :description
      t.string :env
      t.text :content

      t.timestamps
    end
  end
end
