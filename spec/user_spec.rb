require 'rails_helper'

describe 'User behaviour' do

  let(:testuser) { FactoryGirl.create(:user)}

  describe 'respond to different methods' do


    it 'should respond to authenticate ' do
      expect(testuser).to respond_to(:authenticate)
    end

    it 'should respond to remember token' do
      expect(testuser).to respond_to(:remember_token)
    end


  end

  describe 'blank remember token' do

    before do
      testuser.save
    end

    it 'should not have blank remember token' do
      expect(testuser.remember_token).not_to be_blank
    end


  end
end