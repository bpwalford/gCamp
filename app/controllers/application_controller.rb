class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include AuthenticationHelper

  before_action :ensure_user

  rescue_from AccessDenied, with: :four_o_four

  def four_o_four
    render 'public/404', layout: false, status: 404
  end

end
