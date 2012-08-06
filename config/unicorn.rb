worker_processes 3 	# amount of unicorn workers to spin up
timeout 30         	# restarts workers that hang for 30 seconds
preload_app true    # Enabling this preloads an application before forking worker processes. 

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  sleep 1
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end
end