require 'rails_helper'

RSpec.describe 'StaticPages', :type => :feature do
  describe 'GET /static_pages' do

    let(:base_title) {'sample app |'}

    describe 'GET /home page' do
      it 'should load home page and display welcome message' do
        expected_msg = 'Sample App Home Help About Contact Welcome to Sample App
                        This app is just to demonstrate how to develop using Ruby on Rails
                        Sign up now!
                        This site is maintained by Tripartite Inc. @copyright 2016'
        visit static_pages_home_path
        expect(page).to have_content(expected_msg)
      end

      it "should have title as 'sample app | Home' " do
        expected_title = "#{base_title} Home"
        visit static_pages_home_url
        expect(page).to have_title(expected_title)
      end
    end

    describe 'GET /help page' do
      it 'should load help page and display help center no' do
        visit static_pages_help_path
        expected_msg = 'This is help page for this Sample App'
        expect(page).to have_content(expected_msg)
      end

      it "should have title as 'sample app | Help' " do
        expected_title = "#{base_title} Help"
        visit static_pages_help_path
        expect(page).to have_title(expected_title)
      end
    end

    describe 'GET /about page' do
      it 'should load about page and display my profile' do
        visit 'static_pages/about'
        expected_msg = 'This is about page'
        expect(page).to have_content(expected_msg)
      end

      it "should have title as 'sample app | About' " do
        expected_title = "#{base_title} About"
        visit static_pages_about_path
        expect(page).to have_title(expected_title)
      end
    end

    describe 'GET /contact page' do
      it 'should load contact page and display contact info' do
        visit 'static_pages/contact'
        expected_msg = 'This is contact page'
        expect(page).to have_content(expected_msg)
      end
    end

  end
end

