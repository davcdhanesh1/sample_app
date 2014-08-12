require 'rails_helper'
require_relative '../support/utilities'
require_relative '../../app/helpers/users_helper'


RSpec.describe 'UserPages', :type => :feature do

  describe 'users controller spec' do

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

      after(:all) do
        User.destroy_all
      end

      it 'should create new user having valid credentials' do

        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "1234xxxx"
        fill_in "Confirmation", with: "1234xxxx"

        expect { click_button submit }.to change(User, :count).by(1)

      end

      it 'should not create new user having invalid credentials' do

        fill_in "Name", with: "Examp"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "1234"
        fill_in "Confirmation", with: "1234xxxx"


        expect { click_button submit }.to change(User, :count).by(0)

      end

    end

    describe '#show' do

      before(:each) do
        sign_in @user
        visit user_path(@user.id)
      end

      before(:all) do
        @user = FactoryGirl.create(:user)
        50.times { FactoryGirl.create(:idea, user: @user) }
      end

      after(:all) do
        User.destroy_all
      end

      it { should have_content(@user.name) }
      it { should have_title(@user.name) }
      it 'should have microposts count' do
        expect(page).to have_content("50 ideas")
      end

      it 'should have micropost pagination link' do
        all_microposts_from_page_1 = Idea.paginate(page: 1)
        all_microposts_from_page_1.each do |micropost|
          expect(page).to have_content(micropost.content)
        end
      end


    end

    describe '#edit' do

      let(:user) { FactoryGirl.create(:user) }
      let(:newpassword) { 'new password' }
      let(:newname) { 'my new name' }

      before(:each) do
        sign_in user
        visit edit_user_path(user)
      end

      after(:all) do
        User.destroy_all
      end

      describe 'edit_page_layout' do

        it 'should have title as edit' do
          expected_title = "#{base_title} edit"
          expect(page).to have_title(expected_title)
        end

        it 'should have content as edit your profile here' do
          main_content = 'edit your profile here New name New password New password confirmation'
          expected_body = "#{main_content}"
          expect(page).to have_content(expected_body)
        end

        it { should have_link('Profile', href: user_path(user)) }
        it { should have_link('Settings', href: edit_user_path(user)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

      end

      describe 'editing user profile' do

        context 'after successful profile editing' do

          before(:each) do
            fill_in 'user[name]', with: newname
            fill_in 'user[password]', with: newpassword
            fill_in 'user[password_confirmation]', with: newpassword
            click_button 'Save changes'
          end

          it 'should not have any errors' do
            expect(page).to have_selector('div.alert.alert-success')
          end

          it 'should reload user profile page with new changes' do
            expected_title = "#{base_title} #{newname}"
            expect(page).to have_title(expected_title)
          end

          it 'should update user name' do
            expect(user.reload.name).to eq newname
          end

        end

        context 'after unsuccessful profile edit' do

          before(:each) do
            click_button 'Save changes'
          end

          it 'should have error message' do
            expect(page).to have_selector('div.alert.alert-error')
          end

        end

      end

    end

    describe '#index' do

      let(:user) { sign_in FactoryGirl.create(:user) }

      before(:each) do
        visit users_path
      end

      before(:all) do
        35.times { FactoryGirl.create(:user) }
      end

      after(:all) do
        User.destroy_all
      end

      it 'should have title as all users' do
        expected_title = base_title + ' all users'
        expect(page).to have_title(expected_title)
      end

      it 'should have heading as looking for someone' do
        expect(page).to have_content('looking for someone...')
      end

      it 'should have pagination' do
        expect(page).to have_selector('div.pagination')
      end

      it 'should list each user' do
        all_users_from_page_1 = User.paginate(page: 1)
        all_users_from_page_1.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end


    end

    # describe '#follow users' do
    #
    #   describe 'following users' do
    #
    #     before(:all) do
    #       @follower = FactoryGirl.create(:user)
    #       @followed = FactoryGirl.create(:user)
    #     end
    #     after(:all) do
    #       User.destroy_all
    #     end
    #
    #     before(:each) do
    #       sign_in @follower
    #     end
    #
    #     it 'should not have follow_form if goes to his/her own profile' do
    #       visit user_path(@follower)
    #       expect(page).not_to have_button('Follow')
    #       expect(page).not_to have_button('Unfollow')
    #     end
    #
    #     it 'should have count of followers and followed people' do
    #       visit user_path(@follower)
    #       expect(page).to have_link('Following: 0', href: following_user_path(@follower))
    #       expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
    #     end
    #
    #   end
    #
    #   describe 'should add users to the followed users if follow button is submitted' do
    #
    #     before(:all) do
    #       @follower = FactoryGirl.create(:user)
    #       @followed = FactoryGirl.create(:user)
    #     end
    #
    #     after(:all) do
    #       @followed.destroy
    #       @follower.destroy
    #     end
    #
    #     before(:each) do
    #       sign_in @follower
    #       visit user_path(@followed)
    #     end
    #
    #     it 'should have follow button' do
    #       expect(page).to have_button('Follow')
    #     end
    #
    #     it 'should add followed user to the list of followed users if follow button is pressed' do
    #       expect{ click_button 'Follow'}.to change(Relationship, :count).by(1)
    #       expect(page).to have_link('Following: 1', href: following_user_path(@follower))
    #       expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
    #     end
    #
    #   end
    #
    # end

    # describe 'unfollow users' do
    #
    #   before(:all) do
    #     @follower = FactoryGirl.create(:user)
    #     @followed = FactoryGirl.create(:user)
    #     @follower.follow!(@followed)
    #   end
    #   after(:all) do
    #     User.destroy_all
    #   end
    #
    #   before(:each) do
    #     sign_in @follower
    #   end
    #
    #   it 'should decrease the count of following by 1' do
    #     visit user_path(@followed)
    #     expect { click_button 'Unfollow'}.to change(Relationship, :count).by(-1)
    #   end
    #
    #   it 'should update the profile page with new count' do
    #     visit user_path(@followed)
    #     click_button 'Unfollow'
    #     expect(page).to have_link('Following: 0', href: following_user_path(@follower))
    #   end
    #
    # end


  end

end
