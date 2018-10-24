#!/bin/bash
#
#
#
cd `dirname $0`
pwd
# 更新代码
svn up

# 杀进程
ps aux | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9

# 更新数据库
rails db:migrate  RAILS_ENV=production

# 初始化数据库数据
rails db:seed

# 预编译
SECRET_KEY_BASE=`rake secret` bundle exec rake assets:precompile RAILS_ENV=production

# 启动服务
#nohup rails s &
SECRET_KEY_BASE=`rake secret` RAILS_SERVE_STATIC_FILES=true  rails s -e production

# 启动后台任务
nohup bundle exec sidekiq &> nohup.sidekiq.out &
SECRET_KEY_BASE=`rake secret` bundle exec sidekiq  &> nohup.sidekiq.out &
