class HomeController < ApplicationController
  def index
    @redis_alive = RemoteRedis.new().alive?
  end
end
