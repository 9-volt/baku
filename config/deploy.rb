require "rvm/capistrano"
require 'bundler/capistrano'

server "146.185.181.83", :app, :web, :db, :primary => true

set :application, "Baku"
set :repository,  "git@github.com:9-volt/baku.git"
set :deploy_to,   "/home/volt/baku"

set :scm, :git
set :branch, "master"
set :user, "volt"
set :use_sudo, false

set :rails_env, :production
set :deploy_via, :copy
set :keep_releases, 3

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "read-only"

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
