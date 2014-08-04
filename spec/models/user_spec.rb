require 'rails_helper'

describe 'User behaviour' do

  before(:each) do
    @testuser = FactoryGirl.create(:user)
  end

  after(:each) do
    @testuser.destroy
  end

  describe 'respond to different methods' do

    it 'should respond to authenticate ' do
      expect(@testuser).to respond_to(:authenticate)
    end

    it 'should respond to remember token' do
      expect(@testuser).to respond_to(:remember_token)
    end

    it 'should respond to feeds' do
      expect(@testuser).to respond_to(:ideas)
    end

    it 'should respond to relationships' do
      expect(@testuser).to respond_to(:relationships)
      expect(@testuser).to respond_to(:reverse_relationships)
      expect(@testuser).to respond_to(:followed_users)
      expect(@testuser).to respond_to(:following?)
      expect(@testuser).to respond_to(:follow!)
      expect(@testuser).to respond_to(:unfollow!)
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

    let!(:older_micropost) { FactoryGirl.create(:micropost, user: @testuser, created_at: 1.day.ago) }
    let!(:newer_micropost) { FactoryGirl.create(:micropost, user: @testuser, created_at: 1.hour.ago) }

    it 'should respond to micropost associated with it' do
      expect(@testuser).to respond_to(:microposts)
    end

    it 'should delete all the microposts associated with it, if user is deleted' do

      all_microposts = @testuser.microposts.to_a
      @testuser.destroy
      expect(all_microposts).not_to be_empty

      all_microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end

    end

  end

  describe 'ideas' do
    let!(:older_micropost) { FactoryGirl.create(:micropost, user: @testuser, created_at: 1.day.ago) }
    let!(:newer_micropost) { FactoryGirl.create(:micropost, user: @testuser, created_at: 1.hour.ago) }
    let(:other_micropost) { FactoryGirl.create(:micropost, user: FactoryGirl.create(:user)) }


    it "should include it's one's own microposts in one's feeds" do
      expect(@testuser.ideas).to include(older_micropost)
      expect(@testuser.ideas).to include(newer_micropost)
      expect(@testuser.ideas).not_to include(other_micropost)
    end

    describe 'microposts by the followed users' do

      before(:all) do
        @follower = FactoryGirl.create(:user)
        @followed = FactoryGirl.create(:user)
        @other_user = FactoryGirl.create(:user)
        @follower_user_post = FactoryGirl.create(:micropost, user: @follower, content: 'follower post')
        @followed_user_post = FactoryGirl.create(:micropost, user: @followed, content: 'followed user post')
        @unfollowed_user_post = FactoryGirl.create(:micropost, user: @other_user, content: 'unfollowed user post')
        @follower.follow!(@followed)
      end

      after(:all) do
        @follower.destroy
        @followed.destroy
        @other_user.destroy
      end

      it 'should include microposts from followed_users' do
        expect(@follower.ideas).to include(@followed_user_post)
        expect(@follower.ideas).not_to include(@unfollowed_user_post)
      end

      it 'should not include microposts from unfollowed_users' do

      end


    end


  end

  describe 'following' do

    let(:other_user) { FactoryGirl.create(:user) }

    before(:each) do
      @testuser.follow!(other_user)
    end

    it { expect(@testuser.followed_users).to include(other_user) }
    it { expect(@testuser.following?(other_user)).to eq true }

  end

  describe 'unfollowing' do

    let(:other_user) { FactoryGirl.create(:user) }

    before(:each) do
      @testuser.follow!(other_user)
      @testuser.unfollow!(other_user)
    end

    it { expect(@testuser.followed_users).not_to include(other_user) }
    it { expect(@testuser.following?(other_user)).to eq false }

  end

  describe 'followers' do

    let(:other_user) { FactoryGirl.create(:user) }
    before(:each) do
      other_user.follow!(@testuser)
    end

    it { expect(@testuser.followers).to include(other_user) }
    it { expect(other_user.following?(@testuser)).to eq true }


  end

end