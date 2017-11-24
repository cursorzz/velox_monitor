class HomeController < ApplicationController
  def index
    @redis = RemoteRedis.new()
  end
end
