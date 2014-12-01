class ProjectsController < ApplicationController
  before_action :ensure_user
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects.all
  end

  def show
    check_user_projects
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
    check_project_ownership
  end

  def update
    check_project_ownership
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    check_user_projects
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
