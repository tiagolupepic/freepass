workers 4
threads 1, 6

preload_app!

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'development'

bind "tcp://0.0.0.0:" + (ENV['PORT'] || ENV['HTTP_PORT'] || 9292)

preload_app!

on_worker_boot do
end
