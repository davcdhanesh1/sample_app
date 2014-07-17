require 'rails_helper'

RSpec.describe 'StaticPages', :type => :feature do
  describe 'GET /static_pages' do

    describe 'GET /home page' do

      it 'should load home page and display welcome message' do
        expected_msg = 'Hi Welcome to Home Page of Sample App'
        visit static_pages_home_path
        expect(page).to have_content(expected_msg)
      end

    end

  end
end
