class CreateProxies < ActiveRecord::Migration[5.2]
  def change
    create_table :proxies do |t|
      t.string :name
      t.string :url
      t.string :proxytype

      t.timestamps
    end
  end
end
