require 'rails_helper'

RSpec.describe Idea, :type => :model do

  describe 'basic validations for ideas' do

    before(:all) do
      @user = FactoryGirl.create(:user)
      @valid_idea = @user.ideas.create(content: 'This is test post')
      @invalid_idea_type_1 = @user.ideas.build(content: '')
      @invalid_idea_type_2 = @user.ideas.build(content: '#'*501)
    end

    after(:all) do
      @valid_idea.destroy
      @invalid_idea_type_1.destroy
      @invalid_idea_type_2.destroy
      @user.destroy
    end

    it 'should validate content and user_id' do
      expect(@valid_idea).to respond_to(:content)
      expect(@valid_idea).to respond_to(:user_id)
    end

    it 'should have length of minimum 8 char and maximum 8 char' do
      expect(@invalid_idea_type_1).not_to be_valid
      expect(@invalid_idea_type_2).not_to be_valid
    end

    it 'should respond to user associated with idea' do
      expect(@valid_idea.user.id).to eq @user.id
    end


  end

  describe 'ideas should be retrieved in order newest to oldest' do

    let!(:older_idea) { FactoryGirl.create(:idea, user: @user, created_at: 1.day.ago) }
    let!(:new_idea) { FactoryGirl.create(:idea, user: @user, created_at: 1.hour.ago) }

    before(:all) do
      @user = FactoryGirl.create(:user)
    end

    after(:all) do
      @user.destroy
    end

    it 'should be retrieved in reverse order of their creation time' do
      expect(@user.ideas.to_a).to eq [new_idea, older_idea]
    end

  end

end
