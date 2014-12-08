require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  	render_views

  	describe "GET 'new'" do
    	it "returns http success" do
      		get 'new'
      		expect(response).to be_success
    	end
  	end

  	#describe "GET 'show'" do 
  	#	before(:each) do 
  	#		@user = FactoryGirl.build(:user)
  	#	end
	
	  # it "should be successful" do 
  	#		get :show, :id => @user
  	#		expect(response).to be_success
  	#	end

  	#	it "should find the right user" do 
  	#		get :show, :id => @user 
  	#		expect(assigns(:user)) == @user
  	#	end
  	#end

    describe "POST 'create'" do 
      describe "failure" do 
        before(:each) do 
          @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
        end

        it "should not create a user" do 
          expect(lambda do
            post :create, :user => @attr
          end).to_not change(User, :count)
        end

      end

      describe "success" do 
        before(:each) do 
          @attr = { :name => "New User", :email => "user@example.com", :password => "changeme", :password_confirmation => "changeme" }
        end

        it "should create a user" do 
          expect(lambda do 
            post :create, :user => @attr
          end).to change(User, :count).by(1)
        end

        it "should redirect to the user show page" do 
          post :create, :user => @attr
          expect(response).to redirect_to(user_path(assigns(:user)))
        end

      end
    end
end
