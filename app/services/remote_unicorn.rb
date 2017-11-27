class RemoteUnicorn
  include RemoteCall

  def alive?
    result = run %{
      if #{remote_process_exists?(pid_file)}; then
        echo 1;
      else
        echo 0;
      fi
    }
    result == "1"
  end

  def restart!
  end

  def stop!
    run %{
      if #{remote_process_exists?(pid_file)}; then
        echo "-----> Stopping Unicorn...";
        kill -s QUIT `cat #{pid_file}`;
      else
        echo "-----> Unicorn is not running.";
      fi
    }
  end

  def start!
    run %{
      if [ -e "#{pid_file}" ]; then
        if kill -0 `cat #{pid_file}` > /dev/null 2>&1; then
          echo 0;
          exit 0;
        fi;
        rm #{pid_file};
      fi;
      echo "-----> Starting Unicorn...";
      cd #{current_path} && RAILS_ENV=#{env} bundle exec unicorn -c #{current_path}/config/unicorn/#{env}.rb -E #{env} -D
    }
  end

  private

  def root_path
    if Rails.env.production?
      "/apps/velox/"
    else
      "/home/deploy/velox/"
    end
  end

  def env
    if Rails.env.production?
      "production"
    else
      "staging"
    end
  end

  def current_path
    File.join(root_path, "current")
  end

  def pid_file
    File.join(root_path, "shared/tmp/pids/unicorn.pid")
  end

  def unicorn_pid
    %[`cat #{pid_file}`]
  end

  def remote_process_exists?(pid_file)
    "[ -e #{pid_file} ] && kill -0 `cat #{pid_file}` > /dev/null 2>&1"
  end
end
