class TasksController < ApplicationController
  before_action :ensure_user, :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:sort] == "all"
      @tasks = @project.tasks.order(params[:tableSort])
    else
      @tasks = @project.tasks.where(complete: false).order(params[:tableSort])
    end

    @tasksCsv = Task.all
    respond_to do |format|
      format.html
      format.csv { send_data @tasksCsv.to_csv }
    end

  end

  def toggleCompletion

    @task = @project.tasks.find(params[:currentId])

    if @task.complete == false
      @task.complete = true
      @task.save
      redirect_to tasks_path(sort: params[:sort], tableSort: params[:tableSort])
    elsif @task.complete == true
      @task.complete = false
      @task.save
      redirect_to tasks_path(sort: params[:sort], tableSort: params[:tableSort])
    end

  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Tasks was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit(:description, :complete, :due_date)
    end
end
