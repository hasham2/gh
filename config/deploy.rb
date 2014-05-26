set :application, 'greatesthire'
set :repo_url, 'git@github.com:fas1/gh.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deploy/apps/gh'
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :misc do
  desc 'Run seed'
  task :seed do
    on roles(:db), in: :sequence do
      within release_path do
        execute :rake, 'db:seed RAILS_ENV=staging'
      end 
    end
  end
end

namespace :deploy do
  
  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence do
      # Your restart mechanism here, for example:
      execute "echo secret0ne | sudo -S start gh"
    end
  end
  
  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence do
      # Your restart mechanism here, for example:
      execute "echo secret0ne | sudo -S stop gh"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence do
      # Your restart mechanism here, for example:
      execute "echo secret0ne | sudo -S restart gh"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :published, 'deploy:restart'

end
