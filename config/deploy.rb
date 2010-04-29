set :application, "The Game Theory Game"
set :repository,  "git://github.com/schouery/gametheorygame.git"
server = '127.0.0.1'
set :user, 'schouery'

set :scm, :git
set :deploy_to, "/Users/schouery/deploy"
set :branch, 'master'
set :scm_verbose, true
set :deploy_via, :remote_cache

role :web, "127.0.0.1"
role :app, "127.0.0.1"
role :db,  "127.0.0.1", :primary => true

set :runner, user
set :use_sudo, false
set :scm_command, '/opt/local/bin/git'
set :local_scm_command, :default

namespace :deploy do
  desc "Copying database.yml and facebooker.yml"
  task :symlink_shared do
    files = ['database.yml', 'facebooker.yml']
    files.each do |f|
      system "scp config/#{f} #{user}@#{server}:#{shared_path}/"
      run "ln -nfs #{shared_path}/#{f} #{release_path}/config/#{f}"
    end
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# after "deploy:update_code", "gems:install"
# 
# namespace :gems do
#   desc "Install gems"
#   task :install, :roles => :app do
#     run "cd #{current_release} && #{sudo} rake gems:install"
#   end
# end
