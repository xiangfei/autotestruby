# README
 后台rails 5.2 + ruby2.4, 前台 jquery + bootstrap + websocket + smartadmin(第三方模板)
 
## 安装rvm
* curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
* curl -sSL -L -k  https://get.rvm.io | bash -s stable
* source ~/.bash_profile

## 安装依赖包
rvm requirements

## 安装Ruby
rvm install ruby-2.4.2
##  安装mysql
yum -y install mysql mysql-server mysql-client mysql-devel
## 安装npm
yum -y install npm
## 安装redis
yum -y install redis
## 安装gem
+ gem install bundle
+ bundle install

## 配置
+ svn
  1. config/environments/development.rb
+ mail
  1. config/environments/development.rb
+ mysql
  1. config/database.yml
+ sidekiq
  1. config/sidekiq.yml
  2. config/initializers/sidekiq.rb
+ websocket
  1. config/environments/development.rb
+ kaminari
  1. config/initializers/kaminari_config.rb
+ ransack
  1. config/initializers/ransack.rb
+ devise
  1. config/initializers/devise.rb

## 启动
+ development
  1. bundle exec rails db:migrate
  2. bundle exec rails db:seeds
  3. bundle exec rails s
  4. bundle exec sidekiq
+ production
  1. rails db:migrate  RAILS_ENV=production
  2. rails db:seeds  RAILS_ENV=production
  3. SECRET_KEY_BASE=\`rake secret\` bundle exec rake assets:precompile RAILS_ENV=production
  4. SECRET_KEY_BASE=\`rake secret\` RAILS_SERVE_STATIC_FILES=true bundle exec rails s -e production
  5. SECRET_KEY_BASE=\`rake secret\` bundle exec sidekiq  -e production 
