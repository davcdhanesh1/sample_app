require 'rails_helper'
require_relative '../support/utilities'
require_relative '../../app/helpers/users_helper'

RSpec.describe 'IdeaPages', :type => :feature do

  before(:all) do
    @user = FactoryGirl.create(:user)
  end

  after(:all) do
    @user.destroy
  end

  describe 'creating a idea with valid information' do
    let!(:valid_idea_content) { 'Finally a simple test idea twitter' }

    before { sign_in @user }
    before(:each) do
      visit post_new_idea_path
      fill_in 'idea_content', with: valid_idea_content
    end

    it 'should should not have errors' do
      click_button 'Post'
      expect(page).not_to have_selector(error_selector)
    end

    it 'should not increase the count of Ideas' do
      expect { click_button 'Post' }.to change(Idea, :count).by(1)
    end

    it 'should redirect user to his/her profile page to show last tweet' do
      click_button 'Post'
      expect(page).to have_title(base_title + ' ' + @user.name)

    end

  end

  describe 'creating a idea with invalid information' do

    let!(:invalid_idea_content) { '' }

    before { sign_in @user }
    before(:each) do
      visit post_new_idea_path
      fill_in 'idea_content', with: invalid_idea_content
    end

    it 'should should have errors' do
      click_button 'Post'
      expect(page).to have_selector(error_selector)
    end

    it 'should not increase the count of Idea' do
      expect { click_button 'Post' }.not_to change(Idea, :count)
    end

  end

  describe 'deleting a idea' do

    before(:all) do
      @current_user = FactoryGirl.create(:user)
      @current_user_feed = FactoryGirl.create(:idea, user: @current_user, content: 'test idea to destroy')
    end

    after(:all) do
      @current_user.destroy
      @current_user_feed.destroy
    end

    before(:each) do
      sign_in @current_user
      visit user_path(@current_user)
    end

    it 'there should be destroy link for the current user feed' do
      expect(page).to have_link('delete')
    end

    it 'should destroy the idea created by current user' do
      expect { click_link 'delete' }.to change(Idea, :count).by(-1)
    end

  end

end
