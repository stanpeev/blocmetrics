require 'faker'

#Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Internet.password
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

#Create Registered Applications
10.times do
  RegisteredApplication.create!(
    user:     users.sample,
    url:      Faker::Internet.domain_name,
    name:    Faker::App.name
    )
end
registered_applications = RegisteredApplication.all

#Create Events
50.times do
  Event.create!(
    name:     Faker::Hacker.verb
    )
end
events = Event.all

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  email: 'stan.peev@gmail.com',
  password: 's15d27p13',
  name: 'Stan'
  )

puts "Database seeding finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered_applications created"
puts "#{Event.count} events created"
puts
puts "The first user,s email is: #{user.email}"
puts "The first user's password is: #{user.password}"
puts "The first user's name is: #{user.name}"