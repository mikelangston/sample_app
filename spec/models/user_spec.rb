# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do
	before(:each) do
		@attr = { 
			:name => "Example Name", 
			:email => "user@example.com",
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end

	it "should create a new instance given valid attributes" do 
		User.create!(@attr)
	end

	it "should require a name" do 
		no_name_user = User.new(@attr.merge(:name => ""))
		expect(no_name_user).to_not be_valid
	end

	it "should reject names that are too long" do 
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:name => long_name))
		expect(long_name_user).to_not be_valid
	end

	it "should accept valid email addresses" do 
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			expect(valid_email_user).to be_valid
		end
	end

	it "should reject invalid email addresses" do 
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address ))
			expect(invalid_email_user).to_not be_valid
		end
	end

	it "should reject email addresses identical up to case" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		expect(user_with_duplicate_email).to_not be_valid
	end

	describe "password validations" do 
		it "should require a password" do 
			no_password = User.new(@attr.merge(:password => "", :password_confirmation => ""))
			expect(no_password).to_not be_valid
		end

		it "should require a matching password confirmation" do 
			no_match_confirmation = User.new(@attr.merge(:password_confirmation => "invalid"))
			expect(no_match_confirmation).to_not be_valid
		end

		it "should reject short passwords" do 
			short = "a" * 5
			short_password = User.new(@attr.merge(:password => short, :password_confirmation => short))
			expect(short_password).to_not be_valid
		end

		it "should reject long passwords" do 
			long = "a" * 41
			long_password = User.new(@attr.merge(:password => long, :password_confirmation => long))
			expect(long_password).to_not be_valid
		end
	end

	describe "password encryption" do 
		before(:each) do
			@user = User.create!(@attr)
		end

		it "should have an encrypted password attribute" do 
			expect(@user).to respond_to(:encrypted_password)
		end

		it "should set the encrypted password" do 
			expect(@user.encrypted_password).to_not be_blank
		end

		describe "has_password? method" do 
			it "should be true if the passwords match" do 
				expect(@user.has_password?(@attr[:password])).to be_truthy
			end

			it "should be false if the passwords don't match" do 
				expect(@user.has_password?("invalid")).to be_falsey
			end
		end

		describe "authenticate method" do 
			it "should return nil on email/password mismatch" do
				wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
				expect(wrong_password_user).to be_nil
			end

			it "should return nil for an email with no user" do 
				nonexistant_user = User.authenticate("bar@foo.com", @attr[:password])
				expect(nonexistant_user).to be_nil
			end

			it "should return the user on email/password match" do 
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				expect(matching_user) == @user
			end
		end
	end
end
