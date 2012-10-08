require 'spec_helper'

describe Task do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @task = FactoryGirl.create(:task)
  end

  context "user associations" do

    it "should have a users attribute" do
      @task.should respond_to(:users)
    end

    it "should have the right associated users" do
      @task.users << @user
      @task.users.first.should == @user
    end
  end
end