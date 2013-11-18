set :application, "Baku"
set :repository,  "git@github.com:9-volt/baku.git"
set :deploy_to, "/home/volt/baku"

set :scm, :git
set :branch, "master"
set :user, "volt"
set :use_sudo, false

set :rails_env, "production"
set :deploy_via, :copy

server "146.185.181.83", :app, :web, :db, :primary => true
