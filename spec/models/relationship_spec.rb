require 'rails_helper'

RSpec.describe Relationship, :type => :model do

  let!(:follower) { FactoryGirl.create(:user) }
  let!(:followed) { FactoryGirl.create(:user) }
  let!(:relationship) { follower.relationships.build(followed_id: followed.id) }

  describe '#relationship' do

    it 'should validate the relationship between follower and followed' do
      expect(relationship).to be_valid
    end

    it 'should respond to' do
      expect(relationship).to respond_to(:follower_id)
      expect(relationship).to respond_to(:followed_id)
      expect(relationship.follower).to eq follower
      expect(relationship.followed).to eq followed
    end


  end

  describe 'when followed id is not present' do
    before { relationship.followed_id = nil }
    it { expect(relationship).not_to be_valid }
  end

  describe 'when follower id is not present' do
    before { relationship.follower_id = nil }
    it { expect(relationship).not_to be_valid }
  end

end
