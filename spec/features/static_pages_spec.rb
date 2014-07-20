require 'rails_helper'

RSpec.describe 'StaticPages', :type => :feature do
  describe 'GET /static_pages' do

    let(:base_title) { 'sample app |' }

    subject { page }

    describe 'GET /home page' do
      before(:each) do
        visit home_path
      end
      it 'should load home page and display welcome message' do
        expected_msg = 'Sample App Home Help About Contact Welcome to Sample App
                        This app is just to demonstrate how to develop using Ruby on Rails
                        Sign up now!
                        This site is maintained by Tripartite Inc. @copyright 2016'
        should have_content(expected_msg)
      end

      it 'should have title as sample app | Home' do
        expected_title = "#{base_title} Home"
        have_content(expected_title)
      end
    end

    describe 'GET /Help page' do

      before(:each) do
        visit help_path
      end
      it 'should load help page and display help center no' do
        expected_msg = 'This is help page for this Sample App'
        should have_content(expected_msg)
      end

      it 'should have title as sample app | Help' do
        expected_title = "#{base_title} Help"
        should have_title(expected_title)
      end
    end

    describe 'GET /about page' do
      before(:each) do
        visit about_path
      end
      it 'should load about page and display my profile' do
        expected_msg = 'This is about page'
        should have_content(expected_msg)
      end

      it 'should have title as sample app | About' do
        expected_title = "#{base_title} About"
        should have_title(expected_title)
      end
    end

    describe 'GET /contact page' do
      before(:each) do
        visit contact_path
      end
      it 'should load contact page and display contact info' do
        expected_msg = 'This is contact page'
        should have_content(expected_msg)
      end
      it 'should have title as sample app | Contact' do
        expected_title = "#{base_title} Contact"
        should have_title(expected_title)
      end

    end

  end
end

