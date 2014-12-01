class MembershipsController < ApplicationController
  before_action :ensure_user, :set_project

  def index
    check_project_ownership
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    check_project_ownership
    @membership = @project.memberships.new(set_params)

    if @membership.save
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' successfully added to project.'
    else
      @memberships = @project.memberships.all
      render :index
    end
  end

  def update
    check_project_ownership
    @membership = Membership.find(params[:id])
    if @membership.update(set_params)
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was successfully updated.'
    else
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    check_project_ownership
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was removed successfully'
  end

  private

  def set_params
    params.require(:membership).permit(:user_id, :project_id, :status)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
