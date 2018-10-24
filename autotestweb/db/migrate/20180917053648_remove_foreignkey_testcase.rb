class RemoveForeignkeyTestcase < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :testcases, :apps
  end
end
