require 'rails_helper'

describe MembershipsController do

  before do
    @project = create_project
    @member = create_user
    @owner = create_user
    @admin = create_user(admin: true)
    @usership = create_membership(
      project: @project,
      user: @member,
    )
    @ownership = create_membership(
      project: @project,
      user: @owner,
      status: 'owner'
    )

    @other = create_user
    @membership = {
      user_id: @other,
      status: 'member'
    }
  end

  describe '#index' do

    context 'invalid access attempts' do
      it 'renders 404 for non members/owners/adminds' do
        other = create_user
        session[:user_id] = other.id
        get :index, project_id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders the index view for members' do
        session[:user_id] = @member.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders the index view for owners' do
        session[:user_id] = @owner.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders the index view for admins' do
        session[:user_id] = @admin.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end
    end

  end


  describe '#create' do

    context 'invalid access attempts' do
      it 'renders 404 when members try to create memberships' do
        session[:user_id] = @member.id
        post :create, project_id: @project.id, membership: @membership
        expect(response.status).to eq(404)
      end

      it 'renders 404 when non member/owners/admins tory to create memberships' do
        session[:user_id] = @other.id
        post :create, project_id: @project.id, membership: @membership
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts do' do
      it 'renders index when owner save fails' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, membership: {user: 'fail'}
        expect(response).to render_template('index')
      end

      it 'renders index when admin save fails' do
        session[:user_id] = @admin.id
        post :create, project_id: @project.id, membership: {user: 'fail'}
        expect(response).to render_template('index')
      end

      it 'redirects to memberships index when owner creates' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, membership: @membership
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to memberships index when admin creates' do
        session[:user_id] = @admin.id
        post :create, project_id: @project.id, membership: @membership
        expect(response).to redirect_to(project_memberships_path(@project))
      end
    end

  end


  describe '#update' do

    context 'invalid access attempts' do
      it 'renders 404 if member attempts to update' do
        session[:user_id] = @member.id
        put :update, project_id: @project.id, id: @member.id, membership: 'owner'
        expect(response.status).to eq(404)
      end

      it 'renders 404 if non member/owner/admin attempts to update' do
        session[:user_id] = @other.id
        put :update, project_id: @project.id, id: @member.id, membership: 'owner'
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders index if owner save is unsuccessful' do
        session[:user_id] = @owner.id
        put :update, project_id: @project.id, id: @usership.id, membership: {status: 'flarp'}
        expect(response).to render_template('index')
      end

      it 'renders index if admin save is unsuccessful' do
        session[:user_id] = @admin.id
        put :update, project_id: @project.id, id: @usership.id, membership: {status: 'flarp'}
        expect(response).to render_template('index')
      end

      it 'redirects to index if owner save is successful' do
        session[:user_id] = @owner.id
        put :update, project_id: @project.id, id: @usership.id, membership: {status: 'owner'}
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to index if admin save is successful' do
        session[:user_id] = @owner.id
        put :update, project_id: @project.id, id: @usership.id, membership: {status: 'owner'}
        expect(response).to redirect_to(project_memberships_path(@project))
      end
    end

  end


  describe '#destroy' do

    context 'invalid access attempts' do

      before do
        @othership = create_membership(
          project: @project,
          user: @other
        )
      end

      it 'renders 404 if member deletes other member' do
        session[:user_id] = @member.id
        delete :destroy, project_id: @project.id, id: @othership.id
        expect(response.status).to eq(404)
      end

      it 'renders 404 if non member/owner/admin deletes' do
        session[:user_id] = @other.id
        delete :destroy, project_id: @project.id, id: @usership.id
        expect(response.status).to eq(404)
      end

      it 'renders index if the last owner is deleted' do
        session[:user_id] = @admin.id
        delete :destroy, project_id: @project.id, id: @ownership.id
        expect(response).to render_template('index')
      end
    end

    context 'valid access attempts' do
      it 'redirects to index if owner deletes other member' do
        session[:user_id] = @owner.id
        delete :destroy, project_id: @project.id, id: @usership.id
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to index if admin deletes member' do
        session[:user_id] = @admin.id
        delete :destroy, project_id: @project.id, id: @usership.id
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to projects if member deletes self' do
        session[:user_id] = @member.id
        delete :destroy, project_id: @project.id, id: @usership.id
        expect(response).to redirect_to(projects_path)
      end
    end

  end

end
