class CommentsController < ApplicationController

    def create
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:task_id])
      @comment = @task.comments.new(set_params)
      @comment.user = current_user

      if @comment.save
        redirect_to project_task_path(@project, @task)
      else
        redirect_to project_task_path(@project, @task)
      end
    end

    private

    def set_params
      params.require(:comment).permit(:content, :task_id)
    end

end
