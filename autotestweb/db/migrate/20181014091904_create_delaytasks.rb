class CreateDelaytasks < ActiveRecord::Migration[5.2]
  def change
    create_table :delaytasks do |t|
      t.string :app
      t.string :crontab
      t.string :apptype

      t.timestamps
    end
  end
end
