module RemoteCall

  def host_address
    if Rails.env.production?
      "74.207.231.67"
    else
      "192.81.130.233"
    end
  end

  def set_env
    if Rails.env.production?
      rvm_env
    else
      rbenv_env
    end
  end


  def run(cmds)
    before_escape = [set_env, cmds.strip].join("\n")
    print before_escape
    command = Shellwords.escape(before_escape)
    result = `ssh deploy@#{host_address} -p 22 -tt -- #{command}`
    puts result
    result.strip
  end

  def rvm_env
    %[
      source $HOME/.rvm/scripts/rvm
      rvm use "current" --create
    ].strip
  end

  def rbenv_env
    %[
      export RBENV_ROOT="$HOME/.rbenv"
      export PATH="$HOME/.rbenv/bin:$PATH"

      if ! which rbenv >/dev/null; then
        echo "! rbenv not found"
        echo "! If rbenv is installed, check your :rbenv_path setting."
        exit 1
      fi
      eval "$(rbenv init -)"
    ].strip
  end
end
