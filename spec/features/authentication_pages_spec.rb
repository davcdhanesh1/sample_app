require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :feature do

  describe 'GET /authentication_pages' do

    let(:base_title) { 'sample app |' }
    let(:header) { 'Sample App Home Help About Contact Sign in' }
    let(:footer) { 'This site is maintained by Tripartite Inc. @copyright 2016' }

    describe 'signin page layout' do

      before(:each) do
        visit signin_path
      end

      it 'should have title as sample app | sign in ' do

        expected_title = "#{base_title} Sign In"
        expect(page).to have_title(expected_title)

      end

      it 'should have content' do

        body = 'Sign In Email Password New user? Sign up now!'
        expected_body = "#{header} #{body} #{footer}"
        expect(page).to have_content(expected_body)

      end

    end

    describe 'sign in process' do

      before(:each) do
        visit signin_path
      end

      context 'invalid information form submission' do

        describe 'after submitting invalid information' do

          before { click_button 'Sign In' }

          it 'should have error message' do
            expect(page).to have_selector('div.alert.alert-error')
          end

        end

        describe 'after visiting another page' do

          before { visit home_path }

          it 'should not have error message' do
            expect(page).not_to have_selector('div.alert.alert-error')
          end

        end

      end

      context 'valid information is submitted' do

        before(:each) do
          fill_in :email
        end

        describe 'user is authenticated successfully' do

          it 'should redirect to that user page' do
            expect(page).to have_title
          end


        end

      end

    end

  end
end
