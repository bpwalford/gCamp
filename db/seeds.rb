
User.delete_all
Project.delete_all
Task.delete_all
Membership.delete_all
Comment.delete_all

User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'admin@example.com',
  password: 'pass',
  admin: true,
)

60.times do
  User.create! first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: 'asdf',
              password_confirmation: 'asdf'
end


10.times do
  project = Project.create name: Faker::App.name


  rand(1..15).times do
    description = Faker::Lorem.sentence(5)
    description = description.split

    task = Task.new(
      description: description.sample + " " + description.sample,
      due_date: Faker::Date.forward(30),
      complete: [true, false].sample
    )

    project.tasks.append(task)
  end

  rand(1..3).times do
    user = User.all.sample
    if !project.users.include?(user)
      Membership.create!(
        user: user,
        project: project,
        status: 'owner',
      )
    end
  end

  rand(3..10).times do
    user = User.all.sample
    if !project.users.include?(user)
      project.users.append(user)
    end
  end

end
