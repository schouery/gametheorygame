set :application, "The Game Theory Game"
set :repository,  "git://github.com/schouery/gametheorygame.git"
server = 'croata.ime.usp.br'
set :user, 'schouery'

set :scm, :git
set :deploy_to, "/home/schouery/rails/gametheory/"
set :branch, 'master'
set :scm_verbose, true
set :deploy_via, :remote_cache

role :web, "croata.ime.usp.br"
role :app, "croata.ime.usp.br"
role :db,  "croata.ime.usp.br", :primary => true

set :runner, user
set :use_sudo, false

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

after "deploy:symlink", "deploy:update_crontab"
namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end