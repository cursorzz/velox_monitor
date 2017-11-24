module RemoteCall
  def run(cmds)
    command = Shellwords.escape(rvm_env.concat(Array(cmds)).join("\n"))
    `ssh deploy@74.207.231.67 -p 22 -tt -- #{command}`
  end

  def rvm_env
    [
      "source $HOME/.rvm/scripts/rvm",
      'rvm use "current" --create'
    ]
  end
end
