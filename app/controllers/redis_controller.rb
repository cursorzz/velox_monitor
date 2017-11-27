class RedisController < ApplicationController
  def create
    @redis = RemoteRedis.new
    @redis.start!
  end

  def destroy
    @redis = RemoteRedis.new
    @redis.stop!
  end
end
