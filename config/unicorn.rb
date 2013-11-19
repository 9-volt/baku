app_path = "/home/volt/baku"

worker_processes 2
preload_app true
timeout 180
listen "127.0.0.1:8080"

user 'volt', 'deployers'

working_directory "#{app_path}/current"

rails_env = 'production'

stderr_path "#{app_path}/shared/log/unicorn.log"
stdout_path "#{app_path}/shared/log/unicorn.log"

pid "#{app_path}/current/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
