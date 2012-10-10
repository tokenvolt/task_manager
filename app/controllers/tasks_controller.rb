class TasksController < ApplicationController
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index    
    @tasks = current_user.tasks.order "id DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/show
  # GET /tasks/show.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }      
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.users << current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def preshare
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # preshare.html.erb
      format.json { render json: @task }
      format.js { @task }
    end
  end

  def share
    @task = Task.find(params[:id])   
    @user = User.find_by_email(params[:email])

    if @user.nil?  
      redirect_to tasks_url, :flash => { error: "User was not found in the system" }
    else
      @task.users << @user

      @task.update_attributes(params[:task])

      respond_to do |format|
        if @task.update_attributes(params[:task])
          format.html { redirect_to tasks_url, notice: 'Task was successfully shared.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: "preshare" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

end
