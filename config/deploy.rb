# config valid only for Capistrano 3.2.1
lock '3.4.1'

set :username, 'deployer'
set :application, 'goodmeet'
set :rails_env, 'production'
set :repo_url, 'https://github.com/pityara/goodmeet'

set :deploy_to, "/home/#{fetch(:username)}/#{fetch(:application)}"

# capistrano3/unicorn settings
set :unicorn_pid, "#{shared_path}/run/unicorn.pid"
set :unicorn_config_path, "#{shared_path}/config/unicorn.rb"

set :log_level, :info

# Default value for :linked_files is []
set :linked_files, %w{config/secrets.yml config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{public/upload}

namespace :setup do
  desc 'Uploading config files to server'
  task :upload_config do
    on roles(:all) do
      execute :mkdir, "-p #{shared_path}"
      ['shared/config', 'shared/run'].each do |f|
        upload!(f, shared_path, recursive: true)
      end
    end
  end
end

namespace :nginx do
  desc 'Creating symlink in /etc/nginx/conf.d to an application nginx.conf'
  task :append_config do
    on roles :all do
      sudo :ln, "-fs #{shared_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"
    end
  end
  desc 'Reload nginx'
  task :reload do
    on roles :all do
      sudo :service, :nginx, :reload
    end
  end
  desc 'Restart nginx'
  task :restart do
    on roles :all do
      sudo :service, :nginx, :restart
    end
  end
  after :append_config, :restart
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      invoke 'unicorn:restart'
    end
  end

  task :install_js_dependencies do
    on roles(:all) do
      within release_path do
        execute :rake, 'bower:install'
      end
    end
  end

  before :compile_assets, :install_js_dependencies
  after :publishing, :restart
  after :finishing, :cleanup

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
