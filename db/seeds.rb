User.delete_all
Project.delete_all
Task.delete_all
Comment.delete_all
Membership.delete_all

admin = User.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@example.com',
  password: 'password',
  admin: true
)

owner = User.create!(
  first_name: 'Owner',
  last_name: 'User',
  email: 'owner@example.com',
  password: 'password'
)

member = User.create!(
  first_name: 'Member',
  last_name: 'User',
  email: 'member@example.com',
  password: 'password'
)

user = User.create!(
  first_name: 'Basic',
  last_name: 'User',
  email: 'user@example.com',
  password: 'password'
)

me = User.create!(
  first_name: 'asdf',
  last_name: 'asdf',
  email: 'asdf@asdf.com',
  password: 'asdf',
  tracker_token: '15996a007f02afa9b862e890de1b9f74'
)

multiple_owners = Project.create!(name: 'Multiple Owners')

Membership.create!(
  project: multiple_owners,
  user: owner,
  status: 'owner'
)
Membership.create!(
  project: multiple_owners,
  user: user,
  status: 'owner'
)
Membership.create!(
  project: multiple_owners,
  user: member,
  status: 'member'
)

task1 = Task.create!(
  description: "Write 3 comments",
  project: multiple_owners,
  due_date: 4.days.from_now
)

task2 = Task.create!(
  description: "Write 1 comment",
  project: multiple_owners,
  due_date: 5.days.from_now
)

3.times do
  Comment.create!(
  task: task1,
  user: owner,
  content: Faker::Lorem.sentence
  )
end

Comment.create!(
  task: task2,
  user: member,
  content: Faker::Lorem.sentence
)

single_owner = Project.create!(name: 'Single Owner')

Membership.create!(
  project: single_owner,
  user: owner,
  status: 'owner'
)
Membership.create!(
  project: single_owner,
  user: member,
  status: 'member'
)

# User.delete_all
# Project.delete_all
# Task.delete_all
# Membership.delete_all
# Comment.delete_all
#
# User.create!(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   email: 'admin@example.com',
#   password: 'pass',
#   admin: true,
# )
#
# 60.times do
#   User.create! first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name,
#               email: Faker::Internet.email,
#               password: 'asdf',
#               password_confirmation: 'asdf'
# end
#
#
# 10.times do
#   project = Project.create name: Faker::App.name
#
#
#   rand(1..15).times do
#     description = Faker::Lorem.sentence(5)
#     description = description.split
#
#     task = Task.new(
#       description: description.sample + " " + description.sample,
#       due_date: Faker::Date.forward(30),
#       complete: [true, false].sample
#     )
#
#     project.tasks.append(task)
#   end
#
#   rand(1..3).times do
#     user = User.all.sample
#     if !project.users.include?(user)
#       Membership.create!(
#         user: user,
#         project: project,
#         status: 'owner',
#       )
#     end
#   end
#
#   rand(3..10).times do
#     user = User.all.sample
#     if !project.users.include?(user)
#       project.users.append(user)
#     end
#   end
#
# end
