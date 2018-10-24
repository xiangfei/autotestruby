class AddCasetypeToConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :casetype, :string
  end
end
