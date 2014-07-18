require 'rails_helper'

RSpec.describe 'StaticPages', :type => :feature do
  describe 'GET /static_pages' do

    describe 'GET /home page' do
      it 'should load home page and display welcome message' do
        expected_msg = 'Hi Welcome to Home Page of Sample App'
        visit static_pages_home_path
        expect(page).to have_content(expected_msg)
      end

      it "should have title as 'sample app | home' " do
        expected_title = 'sample app | Home'
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
        expected_title = 'sample app | Help'
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
        expected_title = 'sample app | About'
        visit static_pages_about_path
        expect(page).to have_title(expected_title)
      end
    end

  end
end

