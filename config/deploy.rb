require "rvm/capistrano"
require 'bundler/capistrano'
require 'capistrano-unicorn'

set :sidekiq_processes, 1
require 'sidekiq/capistrano'

set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

server "146.185.181.83", :app, :web, :db, :primary => true

set :application, "Baku"
set :repository,  "git@bitbucket.org:9-volt/baku.git"
set :deploy_to,   "/home/volt/baku"

set :scm, :git
set :branch, "master"
set :user, "volt"
set :use_sudo, false

set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 3

set :stages, ["staging", "production"]
set :default_stage, "production"

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "read-only"

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
before "deploy:assets:precompile", "bundle:install"

after "deploy", "deploy:cleanup" # keep only the last 3 releases

after 'deploy:restart', 'unicorn:reload'
after 'deploy:restart', 'unicorn:restart'
after 'deploy:restart', 'unicorn:duplicate'

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
