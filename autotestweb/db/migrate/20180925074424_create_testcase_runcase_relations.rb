class CreateTestcaseRuncaseRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :testcase_runcase_relations do |t|
      t.integer :testcase_id
      t.integer :runtestcase_id

      t.timestamps
    end
  end
end
