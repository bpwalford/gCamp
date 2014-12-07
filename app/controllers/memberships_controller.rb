class MembershipsController < ApplicationController
  before_action :set_project, :check_user_projects
  before_action :check_project_ownership, only: [:create, :update]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @current_membership = current_user.memberships.find_by(project: @project)
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
    # make sure there is always at least one owner
    if @project.memberships.where(status: 'owner').count < 2 && params[:membership][:status] != 'owner'
      @memberships = @project.memberships.all
      @membership = @project.memberships.new
      flash[:error] = 'Projects much have at least one owner'
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

    check_delete_permissions

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

  def check_delete_permissions
    @membership = current_user.memberships.find_by(project: @project)
    unless admin?
      if !@membership || @membership.status == 'member'
        raise AccessDenied unless @membership == Membership.find_by_id(params[:id])
      end
    end
  end

end
