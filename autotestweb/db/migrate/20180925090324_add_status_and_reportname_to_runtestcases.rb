class AddStatusAndReportnameToRuntestcases < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :status, :string
    add_column :runtestcases, :reportname, :string
  end
end
