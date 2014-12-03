require 'rails_helper'

describe ProjectsController do

  describe '#index' do

    it 'renders the index view' do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(response).to render_template('index')
    end

  end


  describe 'show' do

    before do
      @user = create_user
      @project = create_project
      @membership = create_membership(
        user: @user,
        project: @project,
      )
    end

    it 'renders the show view for user projects' do
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response).to render_template('show')
    end

    it 'renders 404 if user is not member' do
      @other = create_user
      session[:user_id] = @other.id
      get :show, id: @project.id
      expect(response.status).to eq(404)
    end

  end


  describe '#new' do

    it 'renders the new project view' do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response).to render_template('new')
    end

  end


  describe '#create' do

    before do
      @user = create_user
      session[:user_id] = @user.id
    end

    it 'redirects to project tasks on save' do
      project = {
        project: {
          name: 'asdf'
        }
      }
      post :create, project
      project = Project.first
      expect(response).to redirect_to(project_tasks_path(project))
    end

    it 'renders new on unsuccessful save' do
      project = {
        project: {
          name: ''
        }
      }
      post :create, project
      expect(response).to render_template('new')
    end

  end


  describe '#edit' do

  end


  describe '#update' do

  end


  describe 'destroy' do

    before do
      @user = create_user
    end

    context 'invalid destroy attempts' do

      it 'renders 404 if member attempts to destroy' do

      end

      it 'renders 404 if non-member attempts to destroy' do
      end

    end

    context 'valid destroy attempts' do

      it 'redirects to users_path if owner destroys' do
      end

      it 'redirects to users_path if admin destroys' do
      end

    end

  end

end
