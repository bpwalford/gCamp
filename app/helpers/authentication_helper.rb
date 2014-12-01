module AuthenticationHelper

  def current_user
    User.find_by(id: session[:user_id])
  end

  def ensure_user
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  def check_user_projects
    if !current_user.projects.include?(@project)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def check_project_ownership
    @membership = current_user.memberships.find_by(project: @project)
    if @membership.status == 'member'
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
