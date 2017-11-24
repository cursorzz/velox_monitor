require 'mina'
require 'mina/deploy'

set :domain, '74.207.231.67'
set :deploy_to, '/apps/velox'
set :repository, 'git@github.com:denis-dev/Veloxcare_Ruby.2013.git'
set :branch, 'master'
set :user, 'deploy'
set :unicorn_config, -> { "#{deploy_to}/#{current_path}/config/unicorn/production.rb" }

set :rvm_use_path, '$HOME/.rvm/scripts/rvm'

desc "rvm use"
task :'rvm:use' do
  args = {env: "current"}
  command %{source #{fetch(:rvm_use_path)}}
  command %{rvm use "#{args[:env]}" --create}
end

desc "sadfdsf"
task :remote_environment do
  invoke :'rvm:use'
end

desc "get redis status"
namespace :god do
  desc "checking god(sidekiq) status"
  task :status do
  end

  desc "Tell God to restart Sidekiq"
  task :restart_sidekiq => :environment do
    command "god restart velox_sidekiq"
  end

  task :start => :environment do
    command "cd $HOME && god -c monitor.god"
  end
end
