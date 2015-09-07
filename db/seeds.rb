PageVisit.create!
new_user = User.create!(
      first_name: "Jim",
      last_name: "Joyce",
      username: "jjoyce1",
      password: "pass",
      password_confirmation: "pass",
      city: "Westmont",
      state: "IL",
      grade: 2015,
      major: "Chemical Engineering",
      birthday: "07/16/1992",
      admin: true)
second_user = User.create!(
      first_name: "Josh",
      last_name: "Joyce",
      username: "josh",
      password: "pass",
      password_confirmation: "pass",
      city: "Denver",
      state: "CO",
      grade: 2017,
      major: "Liberal Arts",
      birthday: "03/22/1994",
      admin: false)

User.create!(
      first_name: "Jim",
      last_name: "Winslow",
      username: "tim",
      password: "pass",
      password_confirmation: "pass",
      city: "Denver",
      state: "CO",
      grade: 2017,
      major: "Liberal Arts",
      birthday: "03/22/1994",
      admin: false)

User.create!(
      first_name: "Kevin",
      last_name: "Dwyer",
      username: "kevin",
      password: "pass",
      password_confirmation: "pass",
      city: "Denver",
      state: "CO",
      grade: 2017,
      major: "Liberal Arts",
      birthday: "03/22/1994",
      admin: false)

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
  20.times do
    post.comments.create!(body: Faker::Lorem.paragraph, user_id: 2)
  end
end