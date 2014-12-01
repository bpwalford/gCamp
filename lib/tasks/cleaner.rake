namespace :cleaner do

  desc "clears database of invalid memberships"
  task memberships: :environment do

    Membership.where.not(user_id: User.all).delete_all

    Membership.where.not(project_id: Project.all).delete_all

  end


  desc "clears database of invalid comments"
  task comments: :environment do

    Comment.where.not(task_id: Task.all).delete_all

    Comment.where.not(user_id: User.all).each {|c| c.user = nil}

  end

end
