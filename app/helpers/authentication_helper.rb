module AuthenticationHelper

  class AccessDenied < StandardError
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def admin?
    current_user.admin? ? true : false
  end

  def ensure_user
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  def check_user
    unless current_user == @user
      raise AccessDenied unless admin?
    end
  end

  def check_user_projects
    if !current_user.projects.include?(@project)
      raise AccessDenied unless admin?
    end
  end

  def check_project_ownership
      @membership = current_user.memberships.find_by(project: @project)
      if @membership.status == 'member'
        raise AccessDenied unless admin?
      end
  end

  def check_project_membership
    unless admin?
      @membership = current_user.memberships.find_by(project: @project)
      unless current_user == @membership.user
        if @membership.status == 'member'
          raise AccessDenied unless admin?
        end
      end
    end
  end

  def friend?(user)
    if current_user.projects.count > 0
      current_user.projects.each do |project|
        if project.users.include?(user)
          return true
        end
      end
      false
    end
  end

end
