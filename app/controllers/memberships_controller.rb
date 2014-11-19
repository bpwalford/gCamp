class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create

    @membership = @project.memberships.new(set_params)

    if @membership.save
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' successfully added to project.'
    else
      @memberships = @project.memberships.all
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(set_params)
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was successfully updated.'
    else
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was removed successfully'
  end

  def set_params
    params.require(:membership).permit(:user_id, :project_id, :status)
  end

end
