class RegisterController < PublicController

  def new
    current_user ? (redirect_to user_path(current_user)) : @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_project_path
    else
      render :new
    end
  end

end
