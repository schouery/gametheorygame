set :application, "The Game Theory Game"
set :repository,  "git://github.com/schouery/gametheorygame.git"
server = '127.0.0.1'
set :user, 'schouery'

set :scm, :git
set :deploy_to, "/Users/schouery/Desktop/deploy"
# set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "127.0.0.1"                          # Your HTTP server, Apache/etc
role :app, "127.0.0.1"                          # This may be the same as your `Web` server
role :db,  "127.0.0.1", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
set :use_sudo, false
set :scm_command, '/opt/local/bin/git'
set :local_scm_command, :default



# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
  task :symlink_shared do
    system "scp config/database.yml #{user}@#{server}:#{shared_path}/"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'