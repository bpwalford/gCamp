class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email))

    respond_to do |format|
      if @user.save
        format.html {redirect_to users_path, notice: "User was successfully created"}
      else
        format.html {render :new}
      end
    end
  end

end
