require 'sidekiq/web'

Rails.application.routes.draw do
  get "appstestcasestastics/:id" ,to: "charts#app_testcase_stastics" , as: "app_testcase_stastics"
  get "projecttestcasestastics/:id" ,to: "charts#project_testcase_stastics" , as: "project_testcase_stastics"
  resources :proxies
  resources :delaytasks
  resources :emails
  resources :emailgroups
  resources :templates
  resources :constants
  get "optimizationlogs", to: "logs#optimizationindex", as: "optimizationindexs"
  resources :logs
  resources :configs
  get "config/svncontent/:id", to: "configs#svncontent", as: "config_svn"
  post "config/updatesvncontent/:id", to: "configs#updatesvncontent", as: "update_config_svn"

  resources :testcases

  get "testcase/getruntestcase", to: "testcases#getruntestcase", as: "get_run_testcase"
  post "testcase/postruntestcase", to: "testcases#postruntestcase", as: "post_run_testcase"
  get "testcase/runtestcaselogs", to: "testcases#runtestcaselogs", as: "run_testcase_logs"

  get "testcase/downloadreport/:id", to: "testcases#downloadreport", as: "download_testcase_report"
  get "get_apps_by_project_id", to: "apps#get_apps_by_project_id", as: "project_id_apps"
  get "get_testcases_by_app_id", to: "testcases#get_testcases_by_app_id", as: "app_id_testcases"
  get "testcase_template(.:format)", to: "testcases#template", as: "download_testcase_template"
  get "testcase/excelupload", to: "testcases#excelupload", as: "testcase_excelupload"
  post "testcase/exceluploadpost", to: "testcases#exceluploadpost", as: "post_testcase_excelupload"
  get "testcase/svncontent/:id", to: "testcases#testcasesvncontent", as: "testcase_svncontent"
  post "testcase/updatesvncontent/:id", to: "testcases#updatetestcasesvncontent", as: "updatetestcase_svncontent"
  get "testcase/errlog/:id", to: "testcases#testcaseerrlog", "as": "testcase_errlog"
  get "gettestcasebycaseid/:caseid", to: "testcases#gettestcasebycaseid"
  resources :servers
  root "apps#index"
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: {sessions: "users/sessions", passwords: "users/passwords"}, path_names: {sign_in: "login", sign_out: "logout", password: "secret", confirmation: "verification", unlock: "unblock", registration: "register", sign_up: "cmon_let_me_in"}

  resources :apps
  resources :projects
  get "sendmessage", to: "message#sendmessage", as: "send_message"
  #devise_for :users
  #get "miscellaneous/login",to: "miscellaneous#login",as: :miscellaneous_login
  #get "miscellaneous/register",to: "miscellaneous#register",as: :miscellaneous_register
  #get "miscellaneous/forgot_password",to: "miscellaneous#forgot_password",as: :miscellaneous_forgot_password
  #get "miscellaneous/locked_screen",to: "miscellaneous#locked_screen",as: :miscellaneous_locked_screen
end
