require "sidekiq-scheduler"

class SpeficWorker
  include Sidekiq::Worker
  include TestcasesHelper
  include ConfigsHelper
  sidekiq_options queue: `hostname`.strip

  #SpeficWorker.set(:queue => `hostname`.strip ).perform_async(*args)
  def perform(*args)
    # Do something
    puts "perform successfully"
  end
end
