# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "create member"

10.times do |n|
  Member.create name: "member_#{n+1}", color: Faker::Color.hex_color
end
members = Member.all

puts "create projects"
3.times do |n|
  Project.create name: "project_#{n+1}", description: "description project #{n+1}"
end

projects = Project.all

puts "create task"
5.times do |n|
  Task.create project_id: projects.pluck(:id).sample,
    title: "task_#{n+1}"
    start_date: (1..5).to_a.sample.day.ago,
    end_date: Date.today + (1..3).to_a.sample.day,
    working_days: (1..8).to_a.sample,
    member_id: members.pluck(:id).sample
end
