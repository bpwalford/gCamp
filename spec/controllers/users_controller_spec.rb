require 'rails_helper'

describe UsersController do

  describe '#index' do

    it 'renders index if a user is logged in' do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(response).to render_template('index')
    end

  end


  describe '#new' do

    it 'renders new if user is logged in' do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response).to render_template('new')
    end

  end


  describe '#create' do

    it 'renders new when save is unsuccessful (i.e. invalid user)' do
      user = create_user
      session[:user_id] = user.id
      user = {user: { first_name: 'asdf'} }
      post :create, user
      expect(response).to render_template('new')
    end

    it 'redirects to users path if successful' do
      user = create_user
      session[:user_id] = user.id
      user = {
        user: {
          first_name: 'asdf',
          last_name: 'asdf',
          email: 'asdf@asdf.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        }
      }
      post :create, user
      expect(response).to redirect_to(users_path)
    end

  end


  describe 'edit' do

    before do
      @user = create_user
    end

    context 'invalid edit page access' do
      it 'renders 404 if user is not user in question or admin' do
        session[:user_id] = @user.id
        @other = create_user
        get :edit, id: @other.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid edit page access' do
      it 'renders edit page for user' do
        session[:user_id] = @user.id
        get :edit, id: @user.id
        expect(response).to render_template('edit')
      end

      it 'renders edit page for admin' do
        @admin = create_user(admin: true)
        session[:user_id] = @admin.id
        get :edit, id: @user.id
        expect(response).to render_template('edit')
      end
    end

  end


  describe 'update' do

    before do
      @user = create_user
      @different = {
        user: {
          first_name: 'different',
          last_name: 'different',
          email: @user.email,
        },
        id: @user.id
      }
    end

    context 'invalid update attempts' do
      it 'renders a 404 is user does not have access' do
        @other = create_user
        session[:user_id] = @user.id
        user = {
          user: {
            first_name: 'different',
            last_name: 'different',
            email: @user.email,
          },
          id: @other.id
        }
        put :update, user
        expect(response.status).to eq(404)
      end
    end

    context 'valid update attempts' do
      it 'redirects to users_path if user updates' do
        session[:user_id] = @user.id
        put :update, @different
        expect(response).to redirect_to(users_path)
      end

      it 'redirects to users_path if admin updates' do
        @admin = create_user(admin: true)
        session[:user_id] = @admin.id
        put :update, @different
        expect(response).to redirect_to(users_path)
      end
    end

  end


  describe 'destroy' do

    before do
      @user = create_user
    end

    context 'invalid destroy attempts' do
      it 'renders 404 non user or admin access' do
        @other = create_user
        session[:user_id] = @user.id
        delete :destroy, id: @other.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid destroy attempts' do
      it 'redirects to signin_path if owner destroys' do
        session[:user_id] = @user.id
        delete :destroy, id: @user.id
        expect(response).to redirect_to(signin_path)
      end

      it 'redirects to users_path if admin destroys' do
        @admin = create_user(admin: true)
        session[:user_id] = @admin.id
        delete :destroy, id: @user.id
        expect(response).to redirect_to(users_path)
      end
    end

  end

end
