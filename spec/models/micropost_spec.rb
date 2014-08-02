require 'rails_helper'

RSpec.describe Micropost, :type => :model do

  describe 'basic validations for microposts' do

    before(:all) do
      @user = FactoryGirl.create(:user)
      @valid_micropost = @user.microposts.build(content: 'This is test post')
      @invalid_micropost_type_1 = @user.microposts.build(content: '')
      @invalid_micropost_type_2 = @user.microposts.build(content: '#'*501)
    end

    after(:all) do
      @valid_micropost.destroy
      @invalid_micropost_type_1.destroy
      @invalid_micropost_type_2.destroy
      @user.destroy
    end

    it 'should validate content and user_id' do
      expect(@valid_micropost).to respond_to(:content)
      expect(@valid_micropost).to respond_to(:user_id)
    end

    it 'should have length of minimum 8 char and maximum 8 char' do
      expect(@invalid_micropost_type_1).not_to be_valid
      expect(@invalid_micropost_type_2).not_to be_valid
    end

    it 'should respond to user associated with micropost' do
      expect(@valid_micropost.user.id).to eq @user.id
    end


  end

  describe 'microposts should be retrieved in order newest to oldest' do

    let!(:older_micropost) { FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago) }
    let!(:new_micropost) { FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago) }

    before(:all) do
      @user = FactoryGirl.create(:user)
    end

    after(:all) do
      @user.destroy
    end

    it 'should be retrieved in reverse order of their creation time' do
      expect(@user.microposts.to_a).to eq [new_micropost, older_micropost]
    end

  end

end
