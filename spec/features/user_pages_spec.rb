require 'rails_helper'


RSpec.describe 'UserPages', :type => :feature do
  describe 'users controller spec' do

    let(:header) { 'Sample App Home Help About Contact' }
    let(:footer) { 'This site is maintained by Tripartite Inc. @copyright 2016' }
    let(:base_title) { 'sample app |' }
    subject { page }

    describe '#new' do

      before(:each) do
        visit new_user_path
        Capybara.exact = true
      end

      it 'should have title as sample app | Sign up' do
        expected_title = "#{base_title} Sign up"
        should have_title(expected_title)
      end
    end

    describe '#create' do

      let(:submit) { 'Create my account' }

      before(:each) do
        visit new_user_path
        Capybara.exact = true
      end

      it 'should create new user having valid credentials' do

        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "1234xxxx"
        fill_in "Confirmation", with: "1234xxxx"

        expect{ click_button submit }.to change(User, :count).by(1)

      end

      it 'should not create new user having invalid credentials' do

        fill_in "Name", with: "Examp"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "1234"
        fill_in "Confirmation", with: "1234xxxx"


        expect{ click_button submit }.to change(User, :count).by(0)

      end

    end

    describe '#show' do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        visit user_path(user.id)
      end

      it { should have_content(user.name) }
      it { should have_title(user.name) }

    end

  end
end