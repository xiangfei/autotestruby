require "sidekiq-scheduler"

class DynamicWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    Delaytask.all.each do |delaytask|
      Sidekiq.set_schedule(delaytask.name, {"cron" => delaytask.crontab, "class" => "TestworkercrontabWorker", "args" => [delaytask.id], "retry" => false})
    end
  end
end
