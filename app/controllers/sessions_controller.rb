class SessionsController < PublicController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to projects_path
    else
      redirect_to signin_path(invalid: true), flash: {error: "Username / password combination invalid"}
    end
  end

  def destroy
    session.clear
    redirect_to home_path
  end

end
