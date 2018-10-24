class AddChinsenameToEmail < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :chinesename, :string
  end
end
