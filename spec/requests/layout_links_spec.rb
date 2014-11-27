require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
    	get '/' 
    	expect(response.status).to be(200)
    end

    it "should have a Contact page at '/contact'" do
    	get '/contact'
    	expect(response.status).to be(200)
    end

    it "should have an About page at '/about'" do
    	get '/about'
    	expect(response.status).to be(200)
    end

    it "should have a Help page at '/help'" do
    	get '/help'
    	expect(response.status).to be(200)
    end

    it "should have a signup page at '/signup'" do
        get '/signup'
        expect(response.status).to be(200)
    end
  end
end
