class AddLogtextToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :logtext, :text
  end
end
