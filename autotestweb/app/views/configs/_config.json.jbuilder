json.extract! config, :id, :app_id, :name, :description, :env, :content, :created_at, :updated_at
json.url config_url(config, format: :json)
