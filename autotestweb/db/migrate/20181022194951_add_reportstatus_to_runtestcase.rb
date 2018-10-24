class AddReportstatusToRuntestcase < ActiveRecord::Migration[5.2]
  def change
    add_column :runtestcases, :reportstatus, :string
  end
end
