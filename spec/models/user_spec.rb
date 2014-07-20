require 'rails_helper'

RSpec.describe User, :type => :model do

  describe User do

    before(:each) do
      @user = User.new({ :name => 'testuser', :email => 'testuser@gmail.com', :password_confirmation => 'foobar',
                         :password => 'foobar' })
    end

    subject { @user }

    it 'should have name and email attribute' do
      should respond_to(:name, :email)
      should be_valid
    end

    it 'should not be valid, if name is empty/blank' do
      @user.name = ''
      should be_invalid
    end

    it 'should not be valid, if email is empty/blank' do
      @user.email = ''
      should be_invalid
    end

    it 'name should be minimum 8 chars and maximum 32 chars in length' do
      @user.name = 'X'*40
      should be_invalid
      @user.name = 'X'*7
      should be_invalid
    end

    describe 'email address should be of format /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i' do

      it 'when email id is not valid' do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]

        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end

      it 'when email id is valid' do
        addresses = %w[user@foo.COM _A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end

      it 'should not allow duplicate email ids' do
        user_with_same_email = @user.dup
        user_with_same_email.save
        should be_invalid
      end

    end

    # describe 'password verification' do
    #   it 'should have password, password_digest, password_confirmation' do
    #     should respond_to(:password)
    #     should respond_to(:password_digest)
    #     should respond_to(:password_confirmation)
    #   end
    #   it 'should have invalid address when password_confirmation doesnt match password' do
    #     @user.password_confirmation = 'mismatch'
    #     should be_invalid
    #   end
    #   it 'should not have empty password' do
    #     @user = User.new({ :name => 'testuser', :email => 'testuser@gmail.com', :password_confirmation => 'i',
    #                        :password => 'i' })
    #     should be_valid
    #   end
    # end

  end
end
