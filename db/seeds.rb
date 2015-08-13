# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: "Jim", last_name: "Joyce", username: "jjoyce1", password: "pass", password_confirmation: "pass", home_town: "Westmont", year: 2015, program: "Super dope program", building: "B")