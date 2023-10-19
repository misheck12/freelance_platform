class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
  
    def index
      @tasks = Task.all
    end
  
    def show
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      @task.client = current_user  # Set the client to the current user
    
      if @task.save
        redirect_to @task, notice: 'Task was successfully created.'
      else
        render :new
      end
    end
    
  
    def edit
    end

    def complete
      @task = Task.find(params[:id])
      if @task.update(completed_file: params[:completed_file], status: "completed")
        redirect_to @task, notice: 'Task was successfully completed.'
      else
        render :show, alert: 'Unable to complete task.'
      end
    end
  
    def update
      @task = Task.find(params[:id])
      if current_user == @task.client && @task.completed? && params[:task][:change_requests].present?
        if @task.update(change_request_params)
          # Notify the freelancer about the change request here, if necessary
          redirect_to @task, notice: 'Change request was successfully sent.'
        else
          render :show
        end
      else
        # ... handle other updates ...
      end
    end

    def accept
      @task = Task.find(params[:id])
      if current_user.freelancer? && @task.open?
        @task.update(freelancer: current_user, status: :in_progress)
        # redirect to show page with a success message
        redirect_to @task, notice: 'Task has been accepted!'
      else
        # redirect to show page with an error message
        redirect_to @task, alert: 'You cannot accept this task!'
      end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
    end
  
    private

    def change_request_params
      params.require(:task).permit(:change_requests)
    end
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :budget, :deadline, :status, :client_id, :freelancer_id, :completed_file)
    end
  end
  