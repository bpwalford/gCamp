module AuthorizationHelper

  class AccessDenied < StandardError
  end

  # *********** user auth helpers *************

  def current_user
    User.find_by(id: session[:user_id])
  end

  def admin?
    current_user.admin? ? true : false
  end

  def ensure_user
    unless current_user
      redirect_to signin_path(attempt: true, place: request.env['PATH_INFO']),
        notice: 'You must be logged in to access that action'
    end
  end

  def check_user
    unless current_user == @user
      raise AccessDenied unless admin?
    end
  end

  def friend?(user)
    if current_user.projects.count > 0
      current_user.projects.each do |project|
        project.users.include?(user) ? (return true) : (return false)
      end
    end
  end

  # *********** project auth helpers *************

  def check_user_projects
    if !current_user.projects.include?(@project)
      raise AccessDenied unless admin?
    end
  end

  def check_project_ownership
    @user_membership = find_user_membership

    if !@user_membership || @user_membership.status == 'member'
      raise AccessDenied unless admin?
    end
  end

  # *********** membership auth helpers *************

  def check_membership_delete_permissions
    @user_membership = find_user_membership

    if !@user_membership || @user_membership.status == 'member'
      raise AccessDenied unless current_users_membership? || admin?
    end
  end

  def last_owner?
    owner_count = @project.memberships.where(status: 'owner').count
    status_param = params[:membership][:status]

    owner_count < 2 && status_param != 'owner' ? true : false
  end

  def find_user_membership
    current_user.memberships.find_by(project: @project)
  end

  def current_users_membership?
    find_user_membership == Membership.find_by_id(params[:id])
  end

end
