# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

new_user = User.create!(first_name: "Jim", last_name: "Joyce", username: "jjoyce1", password: "pass", password_confirmation: "pass", home_town: "Westmont", year: 2015, program: "Super dope program", building: "B")

new_user.events.create!(title: "My Event",
                        all_day: false,
                        start_time: DateTime.now,
                        end_time: DateTime.now.at_noon,
                        url: nil,
                        editable: true,
                        start_editable: true,
                        duration_editable: true)

new_user.events.create!(title: "Late class",
                        all_day: false,
                        start_time: DateTime.new(2015,8,13,4,0,6,'+0'),
                        end_time: DateTime.new(2015,8,13,5,0,6,'+0'),
                        url: nil,
                        editable: true,
                        start_editable: true,
                        duration_editable: true)

new_user.events.create!(title: "Paper due",
                        all_day: false,
                        start_time: DateTime.new(2015,8,13,8,0,6,'+0'),
                        end_time: DateTime.new(2015,8,13,9,33,3,'+0'),
                        url: nil,
                        editable: true,
                        start_editable: true,
                        duration_editable: true)