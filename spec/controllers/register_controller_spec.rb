require 'rails_helper'

describe RegisterController do

  describe '#new' do

    it 'renders the new user page if no one is logged it' do
      get :new
      expect(response).to render_template('new')
    end

    it 'redirects to the current user show page if logged in' do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to(user_path(user))
    end

  end


  describe '#create' do

    it 'sets session redirects to new project path on success' do
      user = {
        first_name: 'asdf',
        last_name: 'asdf',
        email: 'asdf@asdf.com',
        password: 'asdf',
        password_confirmation: 'asdf'
      }
      post :create, user: user
      expect(session[:user_id]).to eq(User.first.id)
      expect(response).to redirect_to(new_project_path)
    end

    it 'renders new on unsuccessful create' do
      user = {
        first_name: 'asdf',
        last_name: 'asdf',
        email: 'asdf@asdf.com',
        password: 'asdf',
        password_confirmation: 'fdsa'
      }
      post :create, user: user
      expect(session[:user_id]).to eq(nil)
      expect(response).to render_template('new')
    end

  end

end
