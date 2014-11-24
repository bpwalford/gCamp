# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Project.delete_all
Task.delete_all
Membership.delete_all

25.times do
  password = rand(1..1000)
  User.create! first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: password,
              password_confirmation: password


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

  rand(1..15).times do

    user = User.all.sample
    if !project.users.include?(user)
      project.users.append(user)
    end

  end

end
