# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

new_user = User.create!(first_name: "Jim", last_name: "Joyce", username: "jjoyce1", password: "pass", password_confirmation: "pass", home_town: "Westmont", year: 2015, program: "Super dope program", building: "B")

second_user = User.create!(first_name: "Jim", last_name: "Joyce", username: "jim", password: "pass", password_confirmation: "pass", home_town: "Chicago", year: 2015, program: "Everything", building: "F")

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

first_post = new_user.posts.create!(title: "Help with research", body: "I don't know what science is please help")

second_user.comments.create!(body: "I don't know either, this stuff is hard...", post_id: first_post.id)

new_user.comments.create!(body: "Well thanks for nothing.", post_id: first_post.id)

20.times do
  new_user.posts.create!(title: Faker::Hacker.say_something_smart, body: Faker::Lorem.paragraph)
end

new_user.posts.each do |post|
  post.comments.create!(body: Faker::Lorem.paragraph, user_id: 2)
end