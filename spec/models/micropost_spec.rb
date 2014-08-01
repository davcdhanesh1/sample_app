require 'rails_helper'

RSpec.describe Micropost, :type => :model do

  describe 'basic validations for microposts' do

    let(:user) { FactoryGirl.create(:user) }
    let(:older_micropost) { FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago) }
    let(:new_micropost) { FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago) }

    before(:each) do

      @valid_micropost = user.microposts.build(content: 'This is test post')
      @invalid_micropost_type_1 = user.microposts.build(content: '')
      @invalid_micropost_type_2 = user.microposts.build(content: '#'*190)

    end

    it 'should validate content and user_id' do
      expect(@valid_micropost).to respond_to(:content)
      expect(@valid_micropost).to respond_to(:user_id)
    end

    it 'should have length of minimum 1 char and max 100 chars' do
      expect(@invalid_micropost_type_1).not_to be_valid
      expect(@invalid_micropost_type_2).not_to be_valid
    end

    it 'should respond to user associated with micropost' do
      expect(@valid_micropost.user).to eq user
    end


  end

  describe 'microposts should be retrieved in order newest to oldest' do

    let(:user) { FactoryGirl.create(:user) }
    let!(:older_micropost) { FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago) }
    let!(:new_micropost) { FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago) }

    it 'should be retrieved in reverse order of their creation time' do
      expect(user.microposts.to_a).to eq [new_micropost, older_micropost]
    end

  end

end
