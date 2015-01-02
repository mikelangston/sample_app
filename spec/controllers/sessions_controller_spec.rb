require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do 
  	describe "invalid signin" do 
  		before(:each) do 
  			@attr = { :emial => "sample@example.com", :password => "invalid" }
  		end

  		it "should re-render the new page" do 
  			post :create, :session => @attr
  			expect(response).to render_template('new')
  		end
  	end

  	describe "valid signin" do 
  		before(:each) do 
  			@user = FactoryGirl.create(:user)
  			@attr = { :email => @user.email, :password => @user.password }
  		end

  		it "should sign the user in" do 
  			post :create, :session => @attr
  			expect(controller.current_user).to eq(@user)
  			expect(controller).to be_signed_in
  		end

  		it "should redirect to the user show page" do 
  			post :create, :session => @attr
  			expect(response).to redirect_to(user_path(@user))
  		end
  	end
  end

  describe "DELETE 'destroy'" do 
  	it "should sign a user out" do 
  		test_sign_in(FactoryGirl.create(:user))
  		delete :destroy
  		expect(controller).to_not be_signed_in
  		expect(response).to redirect_to(root_path)
  	end
  end

end
