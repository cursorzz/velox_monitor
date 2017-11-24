class RemoteRedis
  include RemoteCall

  def alive?
    true
    # stdout = run("god status")
    # stdout.match("up").present?
  end

  def restart!
    run("god restart velox_sidekiq")
  end

  def start!
    run("cd $HOME && god -c monitor.god")
  end
end
