class CreateEmailGroupAndEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :email_group_and_emails do |t|
      t.integer :email_id
      t.integer :emailgroup_id

      t.timestamps
    end
  end
end
