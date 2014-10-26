# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Task.delete_all

20.times do

  Task.create description: Faker::Lorem.sentence(3),
              due_date: Faker::Date.forward(30),
              complete: [true, false].sample

end
