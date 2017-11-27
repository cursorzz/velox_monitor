class HomeController < ApplicationController
  def index
    @redis = RemoteRedis.new()
    @unicorn = RemoteUnicorn.new()
  end
end
