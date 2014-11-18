# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Task.delete_all
User.delete_all
Project.delete_all

14.times do
  password = rand(1..1000)
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: password,
              password_confirmation: password

end


10.times do

  project = Project.create name: Faker::App.name

  rand(1..15).times do

    task = Task.new(
      description: Faker::Lorem.sentence(3),
      due_date: Faker::Date.forward(30),
      complete: [true, false].sample
    )
    task.project = project
    task.save

  end

end
