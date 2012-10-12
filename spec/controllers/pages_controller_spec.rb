require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  describe "GET 'index'" do
  	it "should redirect to home page if user is not signed" do
  		get 'index'
  		response.should be_success
  	end

    it "should redirect to tasks list if user is signed in" do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get 'index'
      response.should redirect_to(tasks_url)
    end
  end

end
