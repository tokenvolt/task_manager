require 'spec_helper'

describe User do

	before(:each) do
	  @user = FactoryGirl.create(:user)
	  @task = FactoryGirl.create(:task)
	end

	context "user associations" do

  	it "should have tasks attribute" do		
  		@user.should respond_to(:tasks)
  	end  

  	it "should have the right associated users" do
        @user.tasks << @task
        @user.tasks.first.should == @task
    end
  end

end
