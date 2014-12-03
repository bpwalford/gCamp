class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include AuthenticationHelper

  rescue_from AccessDenied, with: :four_o_four

  def four_o_four
    if params[:attempt] == 'true'
      redirect_to projects_path
    else
      render 'public/404', layout: false
    end
  end

end
