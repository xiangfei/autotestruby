class CreateTestcases < ActiveRecord::Migration[5.2]
  def change
    create_table :testcases do |t|
      t.string :case_id
      t.string :case_name
      t.boolean :is_done
      t.references :app, foreign_key: true
      t.string :case_type
      t.string :folder_name

      t.timestamps
    end
  end
end
