set :stages, %w(production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "paddlr"
set :scm, "git"
set :repository,  "git@github.com:mza/#{application}.git"
set :branch, "master"
set :user, "root"
set :deploy_to, "/vol/rails/#{application}"
set :scm_verbose, true
set :use_sudo, false
set :keep_releases, 1

ssh_options[:forward_agent] = true
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/id_rsa-gsg-keypair"]
default_run_options[:pty] = true

role :app, "towestminster.com"
role :web, "towestminster.com"
role :db,  "towestminster.com", :primary => true

after "deploy:deploy:finalize_update", "deploy:set_config"
after "deploy:deploy:finalize_update", "deploy:set_ownership"
before "deploy:migrate", "deploy:set_config"

namespace :deploy do
  
  desc "Correctly sets ownership of environment.rb"  
  task :set_ownership do
    run "chown -R www-data:www-data #{current_path}/"    
  end
  
  desc "Upload config"
  task :set_config do
    put File.read('config/deploy/database.server.yml'),  "#{current_path}/config/database.yml"    
  end
  
  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is unnecessary with Passenger"
    task t, :roles => :app do ; end
  end
end