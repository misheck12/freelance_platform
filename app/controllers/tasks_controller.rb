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
      # Add your logic for completing the task here. For example:
      # - Update the task's status
      # - Attach the uploaded file
      # - etc.
  
      # Redirect to a relevant path with a success message, or handle errors as appropriate.
    end
  
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        # Handle the file attachment here
        if params[:task][:submission_file]
          @task.submission_file.attach(params[:task][:submission_file])
        end
        redirect_to @task, notice: 'Task was successfully updated.'
      else
        render :edit
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
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :budget, :deadline, :status, :client_id, :freelancer_id, :completed_file)
    end
  end
  