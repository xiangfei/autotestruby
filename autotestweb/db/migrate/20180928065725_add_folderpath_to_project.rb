class AddFolderpathToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :folderpath, :string
  end
end
