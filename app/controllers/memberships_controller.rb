class MembershipsController < ApplicationController
  before_action :set_project, :check_user_projects
  before_action :check_membership_delete_permissions, only: [:destroy]
  before_action :check_project_ownership, only: [:create, :update]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @current_membership = find_user_membership
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
    if @project.memberships.where(status: 'owner').count < 2 && params[:membership][:status] != 'owner'
      @memberships = @project.memberships.all
      @membership = @project.memberships.new
      flash[:error] = 'Projects must have at least one owner'
      render :index
    else
      @membership = Membership.find(params[:id])
      if @membership.update(set_params)
        redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was successfully updated.'
      else
        @memberships = @project.memberships.all
        render :index
      end
    end
  end

  def destroy

    @membership = Membership.find(params[:id])

    if current_user == @membership.user
      if @membership.destroy
        redirect_to projects_path, notice: "You have successfully eliminated your membership to #{@project.name}"
      else
        @memberships = @project.memberships.all
        render :index
      end
    else
      if @membership.destroy
        redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' was removed successfully'
      else
        @memberships = @project.memberships.all
        render :index
      end
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
