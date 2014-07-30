# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: 'Example User',
                 email: 'example@railstutorial.org',
                 password: '1234foobar',
                 password_confirmation: '1234foobar')
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
