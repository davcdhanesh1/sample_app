
FactoryGirl.define do

  factory :user do
    sequence(:name) {|n| "Person-#{n}"}
    sequence(:email) {|n| "person-#{n}@test.com"}
    password 'iamdhanesh1'
    password_confirmation 'iamdhanesh1'
  end

  factory :idea do
    sequence(:content) {|n| "This is #{n} idea" }
    user
  end

end