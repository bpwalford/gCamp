require 'rails_helper'

describe ProjectsController do

  describe '#index' do

    it 'renders the index view' do
      @user = create_user
      session[:user_id] = @user.id
      get :index
      expect(response).to render_template('index')
    end

  end


  describe '#new' do

    it ''

  end


  describe '#create' do

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
