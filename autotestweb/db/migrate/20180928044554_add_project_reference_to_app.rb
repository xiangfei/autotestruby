class AddProjectReferenceToApp < ActiveRecord::Migration[5.2]
  def change
    add_reference :apps, :project, foreign_key: true
  end
end
