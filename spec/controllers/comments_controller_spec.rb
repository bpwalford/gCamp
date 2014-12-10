require 'rails_helper'

describe CommentsController do

  describe '#create' do

    before do
      @admin = create_user(admin: true)
        @other = create_user
        @project = create_project
        @user = create_user
        @membership = create_membership(
        project: @project,
        user: @user,
      )
      @owner = create_user
      @ownership = create_membership(
        project: @project,
        user: @owner,
        status: 'owner'
      )
      @task = create_task(
        project: @project
      )
    end

    it 'redirects to task path on successful save for members' do
      session[:user_id] = @user.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: 'asdf'}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'redirects to task path on successful save for owners' do
      session[:user_id] = @owner.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: 'asdf'}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'redirects to task path on successful save for admins' do
      session[:user_id] = @admin.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: 'asdf'}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'redirects to task path on unsuccessful save for members' do
      session[:user_id] = @user.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: nil}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'redirects to task path on unsuccessful save for owners' do
      session[:user_id] = @owner.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: nil}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'redirects to task path on unsuccessful save for admins' do
      session[:user_id] = @admin.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: nil}
      expect(response).to redirect_to(project_task_path(@project, @task))
    end

    it 'renders 404 on non member access' do
      session[:user_id] = @other.id
      post :create, project_id: @project.id, task_id: @task.id, comment: {content: 'asdf'}
      expect(response.status).to eq(404)
    end

  end

end
