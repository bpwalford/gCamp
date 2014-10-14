class AboutController < ApplicationController

  def index
    @path = request.env['PATH_INFO']
  end

end
