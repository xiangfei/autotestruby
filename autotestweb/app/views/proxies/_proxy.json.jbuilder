json.extract! proxy, :id, :name, :url, :proxytype, :created_at, :updated_at
json.url proxy_url(proxy, format: :json)
