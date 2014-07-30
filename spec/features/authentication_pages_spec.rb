require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => [:feature, :request] do

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


      context 'valid information form submission' do

        let(:user) { FactoryGirl.create(:user) }

        before(:each) do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign In'
        end

        describe 'after submitting valid information' do

          it 'should redirect the user to profile page' do
            expected_title = "#{base_title} #{user.name}"
            expect(page).to have_title(expected_title)
          end

          it 'should not have any error messages' do
            expect(page).not_to have_selector('div.alert.alert-error')
          end

        end

      end

    end

    describe 'authorization' do

      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, id: '2', email: 'wrong@gmail.com',
                                            password: 'wrongpassword',
                                            password_confirmation: 'wrongpassword'
      ) }

      before(:each) do
        visit edit_user_path(user)
      end

      it 'should not have sign out link' do
        expect(page).not_to have_link('Sign out', href: signout_path)
      end

      context 'user is not logged in but tries to access edit page' do

        describe 'submitting to the update action' do

          it 'should redirect user to the signin page' do
            patch user_path(user)
            expect(response).to redirect_to(signin_path)
          end

        end

        describe 'after successfully sign in it should redirect user to the page he wanted to access' do

          before(:each) do
            fill_in 'session[email]', with: user.email
            fill_in 'session[password]', with: user.password
            click_button 'Sign In'
          end

          it 'should redirect the user to edit page after successfull sign in' do
            expected_title = 'sample app | edit'
            expect(page).to have_title(expected_title)
          end

        end

      end

      context 'incorrect logged in user tries to access edit page of another user' do

        before(:each) do
          sign_in user, no_capybara: true
        end

        describe 'submitting a GET request while logged in as some other user' do

          it 'should redirect such users to root path ' do
            get edit_user_path(wrong_user)
            expect(response).to redirect_to(root_path)
          end

        end

        describe 'submitting the update or edit action while logged in as some other user' do

          it 'should redirect such users to root path' do
            patch user_path(wrong_user)
            expect(response).to redirect_to(root_path)
          end

        end

      end

      describe 'signed_in user tries to access /signin' do

        before(:each) do
          sign_in user, no_capybara: true
        end

        it 'should redirect such users to their profile page' do
          get new_session_path
          expect(response).to redirect_to(user_path(user))

        end

      end

    end

  end

end
