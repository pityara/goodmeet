require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

lock '3.2.1'

set :user, 'deployer'
set :domain, 'boozeit.ru'
set :identity_file, "#{ENV['HOME']}/.ssh/google"
set :deploy_to, '/var/www/boozeit'
set :app_path, lambda { "#{deploy_to}/#{current_path}" }
set :repository, 'https://github.com/pityara/goodmeet'
set :branch, 'master'
set :forward_agent, true


set :rbenv_path, '/home/deployer/.rbenv/'
set :shared_paths, ['config/database.yml', 'log']

task :environment do
   invoke :'rbenv:load'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    invoke :'git:clone'
    invoke :'server:stop_server'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      invoke :'server:start_server'
    end
  end
end

namespace :server do
  desc 'Stop server'
  task :stop_server do
    queue 'echo "-----> Stop Server"'
    queue 'kill -9 $(lsof -i :3000 -t) || true'
    queue '[ -f /var/www/admin/admin_app.pid ] && rm /var/www/admin/admin_app.pid || echo "File admin_app.pid not exist"'
  end

  desc 'Start server'
  task :start_server do
    queue 'echo "-----> Start Server"'
    queue! 'rails s -b 0.0.0.0 -e production -P /var/www/admin/admin_app.pid -d &'
  end
end
