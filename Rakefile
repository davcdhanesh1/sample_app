# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :db do
  desc "Fill database with sample data"

  task populate_user: :environment do
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
end

namespace :db do
  desc 'Fill database with sample posts'
  task populate_microposts: :environment do
    users = User.limit(6)
    users.each do |user|
      32.times do
        content = Faker::Lorem.sentence(5)
        Micropost.create!(content:content,user:user)
      end
    end
  end
end
