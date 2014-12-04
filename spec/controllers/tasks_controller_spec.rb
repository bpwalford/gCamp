require 'rails_helper'

describe TasksController do

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

  describe '#index' do
    context 'invalid access attempts' do
      it 'renders 404 for non members' do
        session[:user_id] = @other.id
        get :index, project_id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders index for members' do
        session[:user_id] = @user.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders index for owners' do
        session[:user_id] = @owner.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders index for admins' do
        session[:user_id] = @admin.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end
    end
  end


  describe '#show' do
    context 'invalid access attempts' do
      it 'renders 404 for non members' do
        session[:user_id] = @other.id
        get :show, project_id: @project.id, id: @task.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders show for members' do
        session[:user_id] = @user.id
        get :show, project_id: @project.id, id: @task.id
        expect(response).to render_template('show')
      end

      it 'renders show for owners' do
        session[:user_id] = @owner.id
        get :show, project_id: @project.id, id: @task.id
        expect(response).to render_template('show')
      end

      it 'renders show for admins' do
        session[:user_id] = @admin.id
        get :show, project_id: @project.id, id: @task.id
        expect(response).to render_template('show')
      end
    end
  end


  describe '#new' do
    context 'invalid access attempts' do
      it 'renders 404 for non members' do
        session[:user_id] = @other.id
        get :new, project_id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders new for members' do
        session[:user_id] = @user.id
        get :new, project_id: @project.id
        expect(response).to render_template('new')
      end

      it 'renders new for owners' do
        session[:user_id] = @owner.id
        get :new, project_id: @project.id
        expect(response).to render_template('new')
      end

      it 'renders new for admins' do
        session[:user_id] = @admin.id
        get :new, project_id: @project.id
        expect(response).to render_template('new')
      end
    end
  end


  describe '#create' do

    before do
      @bad_task = {
        description: 'asdf',
        due_date: Date.today - 1.year
      }
      @good_task = {
        description: 'asdf',
        due_date: Date.today + 1.year
      }
    end

    context 'invalid access attempts' do
      it 'renders 404 for non members' do
        session[:user_id] = @other.id
        post :create, project_id: @project.id, task: @new_task
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders new for members on unsuccessful save' do
        session[:user_id] = @user.id
        post :create, project_id: @project.id, task: @bad_task
        expect(response).to render_template('new')
      end

      it 'renders new for owners on unsuccessful save' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, task: @bad_task
        expect(response).to render_template('new')
      end

      it 'renders new for admins on unsuccessful save' do
        session[:user_id] = @admin.id
        post :create, project_id: @project.id, task: @bad_task
        expect(response).to render_template('new')
      end

      it 'redirect to project tasks for members on successful save' do
        session[:user_id] = @user.id
        post :create, project_id: @project.id, task: @good_task
        expect(response).to redirect_to(project_tasks_path(@project))
      end
  
      it 'redirect to project tasks for owners on successful save' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, task: @good_task
        expect(response).to redirect_to(project_tasks_path(@project))
      end

      it 'redirect to project tasks for admins on successful save' do
        session[:user_id] = @admin.id
        get :create, project_id: @project.id, task: @good_task
        expect(response).to redirect_to(project_tasks_path(@project))
      end
    end

  end


  describe '#edit' do
    context 'invalid access attempts' do
      it 'renders 404 for non members' do
        session[:user_id] = @other.id
        get :edit, project_id: @project.id, id: @task.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders edit for members' do
        session[:user_id] = @user.id
        get :edit, project_id: @project.id, id: @task.id
        expect(response).to render_template('edit')
      end

      it 'renders edit for owners' do
        session[:user_id] = @owner.id
        get :edit, project_id: @project.id, id: @task.id
        expect(response).to render_template('edit')
      end

      it 'renders edit for admins' do
        session[:user_id] = @admin.id
        get :edit, project_id: @project.id, id: @task.id
        expect(response).to render_template('edit')
      end
    end
  end


  describe '#update' do
    context 'invalid access attempts' do
    end

    context 'valid access attempts' do
    end
  end


  describe '#destroy' do
    context 'invalid access attempts' do
    end

    context 'valid access attempts' do
    end
  end

end
