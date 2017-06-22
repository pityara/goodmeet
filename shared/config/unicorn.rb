# working directories of a project on a server
root        = '/home/deploy/boozeit'
rails_root  = "#{root}/current"

# unicorn proccesses pid's
pidfile     = "#{root}/shared/run/unicorn.pid"
pidfile_old = pidfile + '.oldbin'
pid pidfile

# main params
worker_processes 3
preload_app true
timeout 30

# socket path
listen "#{root}/shared/run/unicorn.sock", backlog: 1024, tcp_nopush: false

# logs path
stderr_path "#{rails_root}/log/unicorn_error.log"
stdout_path "#{rails_root}/log/unicorn.log"

# garbage collector settings
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

# before server start instructions
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
end

# instructions for managing workers and db connection

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if File.exists?(pidfile_old) && server.pid != pidfile_old
    begin
      Process.kill("QUIT", File.read(pidfile_old).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
