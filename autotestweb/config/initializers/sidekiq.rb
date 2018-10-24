Sidekiq.configure_server do |config|
  config.redis = {url: "redis://192.168.213.59:6379/12"}
end

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://192.168.213.59:6379/12"}
end
