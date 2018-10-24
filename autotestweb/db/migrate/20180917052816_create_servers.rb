class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string :ip
      t.string :username
      t.string :password
      t.integer :port

      t.timestamps
    end
  end
end
