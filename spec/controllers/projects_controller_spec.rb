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

    context 'invalid requests to view' do
      it 'renders 404 if user is not member' do
        @other = create_user
        session[:user_id] = @other.id
        get :show, id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid requests to view' do
      it 'renders the show view for user projects' do
        session[:user_id] = @user.id
        get :show, id: @project.id
        expect(response).to render_template('show')
      end

      it 'renders the show view for admins' do
        @admin = create_user(admin: true)
        session[:user_id] = @admin.id
        get :show, id: @project.id
        expect(response).to render_template('show')
      end
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
      expect(response).to redirect_to(project_tasks_path(Project.first))
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

    before do
      @member = create_user
      @owner = create_user
      @project = create_project
      @membership = create_membership(
        user: @member,
        project: @project,
      )
      @ownership = create_membership(
        user: @owner,
        project: @project,
        status: 'owner'
      )
    end

    context 'invalid access attempts' do
      it 'renders 404 if not an owner' do
        session[:user_id] = @member.id
        get :edit, id: @project
        expect(response.status).to eq(404)
      end

      it 'renders 404 if not a member' do
        foreign = create_user
        session[:user_id] = foreign.id
        get :edit, id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders edit view if you are an owner' do
        session[:user_id] = @owner
        get :edit, id: @project.id
        expect(response).to render_template('edit')
      end
    end

  end

  describe '#update' do

    before do
      @member = create_user
      @owner = create_user
      @project = create_project
      @membership = create_membership(
        user: @member,
        project: @project,
      )
      @ownership = create_membership(
        user: @owner,
        project: @project,
        status: 'owner'
      )
      @different = {
        project: {
          name: 'different'
        },
        id: @project.id
      }
    end

    context 'invalid attempts to edit' do
      it 'renders 404 if you a not associated' do
        foreign = create_user
        session[:user_id] = foreign.id
        get :update, @different
        expect(response.status).to eq(404)
      end

      it 'renders 404 if you are a member' do
        session[:user_id] = @member.id
        put :update, @different
        expect(response.status).to eq(404)
      end
    end

    context 'valid attempts to edit' do
      it 'renders edit on unsuccessful update' do
        session[:user_id] = @owner
        different = {
          project: {
            name: ''
          },
          id: @project.id
        }
        get :update, different
        expect(response).to render_template('edit')
      end
      it 'redirects to project path on successful update' do
        session[:user_id] = @owner.id
        put :update, @different
        expect(response).to redirect_to(project_path(Project.first))
      end
      it 'redirects to project path when admins update it' do
        @admin = create_user(admin: true)
        session[:user_id] = @admin.id
        put :update, @different
        expect(response).to redirect_to(project_path(Project.first))
      end
    end

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
