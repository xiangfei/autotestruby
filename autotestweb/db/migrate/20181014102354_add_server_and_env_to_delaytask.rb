class AddServerAndEnvToDelaytask < ActiveRecord::Migration[5.2]
  def change
    add_column :delaytasks, :server, :string
    add_column :delaytasks, :env, :string
  end
end
