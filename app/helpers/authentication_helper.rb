module AuthenticationHelper

  def current_user
    User.find_by(id: session[:user_id])
  end

  def ensure_user
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

end
