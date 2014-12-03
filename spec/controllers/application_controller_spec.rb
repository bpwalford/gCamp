require 'rails_helper'

describe ApplicationController do

  controller do
    def index
      render nothing: true
    end
  end

  it "redirects when user are not logged in" do
    get :index

    expect(response).to redirect_to(signin_path(attempt: true, place: '/anonymous'))
  end

end
