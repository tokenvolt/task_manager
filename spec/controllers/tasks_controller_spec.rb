require 'spec_helper'

describe TasksController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user_with_tasks)
    @task = FactoryGirl.create(:task)
    sign_in @user
  end

  describe "GET index" do#    
    it "should be successful" do
      get 'index'
      response.should be_success      
    end

    it "should render the index template" do
      get :index
      response.should render_template "index"
    end
  end

  describe "GET new" do
    it "should assign a new task as @task" do
      get :new, {}
      assigns(:task).should be_a_new(Task)
    end
  end

  describe "POST create" do
    it "should create a new task and save it to the database" do
      Task.any_instance.should_receive(:save)
      post :create, { :id => @task.to_param }
    end
  end    

  describe "GET show" do
    it "should assign the requested task to @task" do          
      get :show, {:id => @task.to_param}
      assigns(:task).should eq(@task)
    end
  end

  describe "GET edit" do
    it "should assign the requested task as @task" do       
      get :edit, {:id => @task.to_param}
      assigns(:task).should eq(@task)
    end
  end

  describe "DELETE destroy" do
    it "should destroy the requested task" do      
      expect {
        delete :destroy, {:id => @task.to_param}
      }.to change(Task, :count).by(-1)
    end

    it "should redirect to the tasks list" do      
      delete :destroy, {:id => @task.to_param}
      response.should redirect_to(tasks_url)
    end
  end

  describe "GET preshare" do
    it "should assign the requested task as @task" do      
      get :preshare, {:id => @task.to_param}
      assigns(:task).should eq(@task)
    end    
  end

  describe "PUT update" do
    context "with valid params" do
      it "should update the requested task" do       
        Task.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @task.to_param, :task => {'these' => 'params'}}
      end

      it "should assign the requested task as @task" do        
        put :update, {:id => @task.to_param}
        assigns(:task).should eq(@task)
      end

      it "should redirect to the task" do        
        put :update, {:id => @task.to_param}
        response.should redirect_to(tasks_url)
      end
    end

    context "with invalid params" do
      it "should assign the task as @task" do          
        Task.any_instance.stub(:save).and_return(false)
        put :update, {:id => @task.to_param, :task => {}}
        assigns(:task).should eq(@task)
      end

      it "re-renders the 'edit' template" do
        Task.any_instance.stub(:save).and_return(false)
        put :update, {:id => @task.to_param, :task => {}}
        response.should render_template("edit")
      end
    end


  end
end
