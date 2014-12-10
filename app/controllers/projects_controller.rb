require 'pivotal_tracker'

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :check_user_projects, only: [:show, :destroy]
  before_action :check_project_ownership, only: [:edit, :update, :destroy]

  def index
    admin? ? @projects = Project.all : @projects = current_user.projects.all

    if current_user.tracker_token
      @tracker_projects = PivotalTracker.new.get_projects(current_user.tracker_token)
    end

  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      Membership.create!(
        project: @project,
        user: current_user,
        status: 'owner',
      )
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.memberships.each {|m| m.valid_destroy = true && m.save}
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
