class MembershipsController < ApplicationController
  before_action :ensure_user, :set_project, :check_user_projects
  before_action :check_project_membership, only: [:create, :update, :destroy]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @current_membership = current_user.memberships.find_by(project: @project)
  end

  def member_index

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
    if current_user == @membership.user
      @membership.destroy
      redirect_to projects_path, notice: "You have successfully eliminated your membership to #{@project.name}"
    else
      @membership.destroy
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was removed successfully'
    end
  end

  private

  def set_params
    params.require(:membership).permit(:user_id, :project_id, :status)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
