class MembershipsController < ApplicationController
  before_action :set_project, :check_user_projects
  before_action :check_project_ownership, only: [:create, :update]
  before_action :check_membership_delete_permissions, only: [:destroy]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @current_membership = find_user_membership
  end

  def create
    @membership = @project.memberships.new(set_params)
    @memberships = @project.memberships.all

    if @membership.save
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' successfully added to project.'
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @memberships = @project.memberships.all

    if last_owner?
      flash[:error] = 'Projects must have at least one owner'
      render :index
    elsif @membership.update(set_params)
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was successfully updated.'
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])

    if @membership.destroy && current_user == @membership.user
      redirect_to projects_path, notice: "You have successfully eliminated your membership to #{@project.name}"
    elsif @membership.destroy
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was removed successfully'
    else
      @memberships = @project.memberships.all
      render :index
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
