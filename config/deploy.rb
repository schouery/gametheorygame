set :application, "The Game Theory Game"
set :repository,  "git://github.com/schouery/gametheorygame.git"
server = '127.0.0.1'
set :user, 'schouery'

set :scm, :git
set :deploy_to, "/Users/schouery/Desktop/deploy"
set :branch, 'master'
set :scm_verbose, true

role :web, "127.0.0.1"
role :app, "127.0.0.1"
role :db,  "127.0.0.1", :primary => true

set :runner, user
set :use_sudo, false
set :scm_command, '/opt/local/bin/git'
set :local_scm_command, :default

namespace :deploy do
  task :symlink_shared do
    files = ['database.yml', 'facebooker.yml']
    files.each do |f|
      system "scp config/#{f} #{user}@#{server}:#{shared_path}/"
      run "ln -nfs #{shared_path}/#{f} #{release_path}/config/#{f}"
    end
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'