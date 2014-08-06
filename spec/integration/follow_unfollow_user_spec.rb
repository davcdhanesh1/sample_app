require 'rails_helper'
require_relative '../support/utilities'
require_relative '../../app/helpers/users_helper'

RSpec.describe 'follow_unfollow_user_integration_spec', :type => :feature do

  before(:all) do
    User.destroy_all
  end

  after(:all) do
    User.destroy_all
  end

  describe '#follow users' do

    before(:each) do
      @follower = FactoryGirl.create(:user)
      @followed = FactoryGirl.create(:user)
    end

    after(:each) do
      User.destroy_all
    end

    describe 'following users' do

      before(:each) do
        sign_in @follower
      end

      it 'should not have follow_form if goes to his/her own profile' do
        visit user_path(@follower)
        expect(page).not_to have_button('Follow')
        expect(page).not_to have_button('Unfollow')
      end

      it 'should have count of followers and followed people' do
        visit user_path(@follower)
        expect(page).to have_link('Following: 0', href: following_user_path(@follower))
        expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
      end

    end

    describe 'should add users to the followed users if follow button is submitted' do

      before(:each) do
        sign_in @follower
        visit user_path(@followed)
      end

      it 'should have follow button' do
        expect(page).to have_button('Follow')
      end

      it 'should add followed user to the list of followed users if follow button is pressed' do
        expect { click_button 'Follow' }.to change(Relationship, :count).by(1)
        expect(page).to have_link('Following: 1', href: following_user_path(@follower))
        expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
      end

    end

  end

  describe 'unfollow users' do

    before(:each) do
      @follower = FactoryGirl.create(:user)
      @followed = FactoryGirl.create(:user)
    end

    after(:each) do
      User.destroy_all
    end

    describe 'unfollowing users' do

      before(:each) do
        sign_in @follower
      end

      it 'should not have follow_form if goes to his/her own profile' do
        visit user_path(@follower)
        expect(page).not_to have_button('Follow')
        expect(page).not_to have_button('Unfollow')
      end
      it 'should have count of followers and followed people' do
        visit user_path(@follower)
        expect(page).to have_link('Following: 0', href: following_user_path(@follower))
        expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
      end

    end

    describe 'should remove user from the followed users if unfollow button is submitted' do

      before(:each) do
        sign_in @follower
        @follower.follow!(@followed)
        visit user_path(@followed)
      end

      it 'should have unfollow button' do
        expect(page).to have_button('Unfollow')
      end

      it 'should remove followed user from the list of followed users if unfollow button is pressed' do
        puts @followed.id
        expect { click_button 'Unfollow' }.to change(Relationship, :count).by(-1)
        expect(page).to have_link('Following: 0', href: following_user_path(@follower))
        expect(page).to have_link('Followers: 0', href: followers_user_path(@follower))
      end

    end

  end

end