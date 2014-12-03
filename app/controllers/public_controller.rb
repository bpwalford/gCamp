class PublicController < ApplicationController

  skip_before_action :ensure_user

end
