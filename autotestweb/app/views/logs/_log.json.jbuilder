json.extract! log, :id, :controller, :action, :user, :params, :objid, :method, :created_at, :updated_at
json.url log_url(log, format: :json)
