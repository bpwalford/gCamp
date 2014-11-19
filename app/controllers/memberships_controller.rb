class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = Membership.where(project_id: @project.id)
  end

  def create

    @membership = @project.memberships.new(set_params)
    # @membership.user_id = params[:membership][:user_id]
    # @membership.status = params[:membership][:status]

    if @membership.save
      redirect_to project_memberships_path(@project), notice: @membership.user.full_name + ' successfully added to project.'
    else
      @memberships = Membership.where(project_id: @project.id)
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(set_params)
      redirect_to project_memberships_path(@project), notice: 'User successfully updated.'
    else
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: 'Member successfully removed'
  end

  def set_params
    params.require(:membership).permit(:user_id, :project_id, :status)
  end

end
