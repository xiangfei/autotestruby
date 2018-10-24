class ChangeRunTestcaselogtextTolongtext < ActiveRecord::Migration[5.2]
  def change
    change_column :runtestcases, :logtext, :longtext
  end
end
