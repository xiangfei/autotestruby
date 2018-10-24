require "sidekiq-scheduler"

class SyncSvnTestcaseWorker
  include Sidekiq::Worker
  include TestcasesHelper
  include ConfigsHelper

  def perform(*args)
    # Do something
    sync_configfile_in_svn
    sync_testcase_in_svn
    puts "sync testcase successfully"
  end
end
