require 'rails_helper'

describe 'User behaviour' do

  before(:each) do
    @testuser = FactoryGirl.create(:user)
  end

  describe 'respond to different methods' do


    it 'should respond to authenticate ' do
      expect(@testuser).to respond_to(:authenticate)
    end

    it 'should respond to remember token' do
      expect(@testuser).to respond_to(:remember_token)
    end


  end

  describe 'blank remember token' do

    before do
      @testuser.save
    end

    it 'should not have blank remember token' do
      expect(@testuser.remember_token).not_to be_blank
    end

  end

  describe 'microposts' do

    before do
      @testuser.save
    end

    after do
      @testuser.destroy
    end

    let!(:older_micropost) {FactoryGirl.create(:micropost, user: @testuser, created_at: 1.day.ago)}
    let!(:newer_micropost)  {FactoryGirl.create(:micropost, user: @testuser, created_at: 1.hour.ago)}

    it 'should respond to micropost associated with it' do
      expect(@testuser).to respond_to(:microposts)
    end

    it 'should delete all the microposts associated with it, if user is deleted' do

      all_microposts = @testuser.microposts.to_a
      @testuser.destroy
      expect(all_microposts).not_to be_empty

      all_microposts.each do|micropost|
        expect(Micropost.where(id:micropost.id)).to be_empty
      end

    end

  end

end