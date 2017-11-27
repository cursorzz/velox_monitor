class RemoteRedis
  include RemoteCall

  def alive?
    # true
    stdout = run("god status")
    stdout.match("up").present?
  end

  def restart!
    stdout = run %[
      god restart velox_sidekiq
]
  end

  def stop!
    stdout = run %[
      god stop velox_sidekiq
    ]
  end

  def start!
    stdout = run %[
      god start velox_sidekiq
    ]
  end
end
