# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    make_ideas
    make_relationships
  end
end

def make_users
  User.create!(name: 'davcdhanesh1',
               email: 'davcdhanesh1@gmail.com',
               password: 'iamdhanesh1',
               password_confirmation: 'iamdhanesh1')
  49.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@test.com"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_ideas
    users = User.limit(6)
    users.each do |user|
      32.times do
        content = Faker::Lorem.sentence(5)
        Idea.create!(content: content, user: user)
      end
    end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[25..50]
  followers      = users[3..24]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
