class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User was successfully created"
    else
      render :new
    end

  end

  def update

    if @user.update(user_params)
       redirect_to users_path, notice: 'User was successfully updated.'
    else
       render :new
    end

  end

  def destroy

    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted'

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
