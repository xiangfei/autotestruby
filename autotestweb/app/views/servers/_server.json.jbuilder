json.extract! server, :id, :ip, :username, :password, :port, :created_at, :updated_at
json.url server_url(server, format: :json)
