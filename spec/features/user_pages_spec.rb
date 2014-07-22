require 'rails_helper'

RSpec.describe 'UserPages', :type => :feature do
  describe 'GET /user_pages' do

    let(:header) { 'Sample App Home Help About Contact' }
    let(:footer) { 'This site is maintained by Tripartite Inc. @copyright 2016' }
    let(:base_title) { 'sample app |' }
    subject { page }

    describe 'GET /users/new' do

      before(:each) do
        visit users_signup_path
        Capybara.exact = true
      end

      it 'should load users/new page and display This is new User page for this Sample App' do
        visit users_signup_path
        expected_body = 'This is sign up page for this Sample App'
        should have_content("#{header} #{expected_body} #{footer}")
      end

      it 'should have title as sample app | New User' do
        expected_title = "#{base_title} New User"
        should have_title(expected_title)
      end

    end


  end
end
