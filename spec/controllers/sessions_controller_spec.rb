require 'rails_helper'

describe SessionsController do

  before do
    @user = create_user(
      email: 'asdf@asdf.com',
      password: 'asdf'
    )
    @project = create_project
    @membership = create_membership(
      user: @user,
      project: @project
    )
    @tcejorp = create_project
  end

  describe '#create' do

    it 'redirects to signin path with invalid credetials' do
      post :create, session: {email: 'asdf', password: 'asdf'}
      expect(response).to redirect_to(signin_path(invalid: true))
    end

    it 'redirects to attempted destination upon login after attempt' do
      post :create,
        session: {
          email: 'asdf@asdf.com',
          password: 'asdf',
          attempt: 'true',
          place: "/project/#{@project.id}"
        }
      expect(response).to redirect_to("/project/#{@project.id}")
      expect(session[:user_id]).to eq(@user.id)
    end

    it 'redirects to projects when attempted request was not accessible' do
      post :create,
        session: {
          email: 'asdf@asdf.com',
          password: 'asdf',
          attempt: 'true',
          place: "/project/#{@tcejorp.id}"
        }
      expect(response).to redirect_to(projects_path)
      expect(session[:user_id]).to eq(@user.id)
    end

  end


  describe '#destroy' do
  end

end
