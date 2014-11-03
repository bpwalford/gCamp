class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      redirect_to signin_path, notice: 'email or password was invalid'
    end
  end

  def destroy
    session.clear
    redirect_to home_path
  end

end
