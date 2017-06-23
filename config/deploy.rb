# config valid only for Capistrano 3.2.1
lock '3.8.2'

set :username, 'deploy'
set :application, 'boozeit'
set :rails_env, 'production'
set :repo_url, 'https://github.com/pityara/goodmeet.git'

set :deploy_to, "/home/#{fetch(:username)}/#{fetch(:application)}"

# capistrano3/unicorn settings
set :unicorn_pid, "#{shared_path}/run/unicorn.pid"
set :unicorn_config, "#{shared_path}/config/unicorn.rb"

set :log_level, :info

# Default value for :linked_files is []
set :linked_files, %w{config/secrets.yml config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{public/upload}

namespace :setup do
  desc 'Загрузка конфигурационных файлов на сервер'
  task :upload_config do
    on roles(:all) do
      sitemap:refresh
      execute :mkdir, "-p #{shared_path}"
      ['shared/config', 'shared/run'].each do |f|
        upload!(f, shared_path, recursive: true)
      end
    end
  end
end
namespace :application do
  desc 'Запуск Unicorn'
  task :start do
    on roles(:app) do
      execute "cd #{release_path} && ~/.rvm/bin/rvm default do bundle exec unicorn_rails -c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end
  desc 'Завершение Unicorn'
  task :stop do
    on roles(:app) do
      execute "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -9 `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end
end
namespace :nginx do
  desc 'Создание симлинка в /etc/nginx/conf.d на nginx.conf приложения'
  task :append_config do
    on roles :all do
      sudo :ln, "-fs #{shared_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"
    end
  end
  desc 'Релоад nginx'
  task :reload do
    on roles :all do
      sudo :service, :nginx, :reload
    end
  end
  desc 'Рестарт nginx'
  task :restart do
    on roles :all do
      sudo :service, :nginx, :restart
    end
  end
  after :append_config, :restart
end



namespace :deploy do
  after :finishing, 'application:stop'
  after :finishing, 'application:start'
  after :finishing, :cleanup
end
