class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = Membership.all
    # @users = @project.memberships.all

    # need to find individual memberships

  end

  def create
    @membership = Membership.new
    @membership.project_id = @project.id
    @membership.user_id = params[:membership][:user_id]
    @membership.status = params[:membership][:status]
    if @membership.save(set_params)
      redirect_to project_memberships_path(@project), notice: 'User successfully added to project.'
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(set_params)
      redirect_to project_memberships_path(@project), notice: 'User successfully updated.'
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project)
  end

  def set_params
    params.require(:membership).permit(:user_id, :project_id, :status)
  end

end
