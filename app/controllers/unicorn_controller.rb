class UnicornController < ApplicationController
  def create
    @unicorn = RemoteUnicorn.new
    @unicorn.start!
  end

  def destroy
    @unicorn = RemoteUnicorn.new
    @unicorn.stop!
  end
end
