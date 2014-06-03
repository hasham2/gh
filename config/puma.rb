# inspired by https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
workers Integer(ENV['PUMA_WORKERS'] || 2)
threads Integer(ENV['MIN_THREADS'] || 1), Integer(ENV['MAX_THREADS'] || 3)

#pidfile 'tmp/pids/puma.pid'
bind 'unix:///tmp/stage.sock'

daemonize
preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'staging'

on_worker_boot do
  #worker specific setup
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
