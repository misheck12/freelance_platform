class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :changes]

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

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def accept
    if current_user.freelancer? && @task.open?
      @task.update(freelancer: current_user, status: :in_progress)
      redirect_to @task, notice: 'Task has been accepted!'
    else
      redirect_to @task, alert: 'You cannot accept this task!'
    end
  end

  def complete
    if @task.update(completed_file: params[:completed_file], status: "completed")
      redirect_to @task, notice: 'Task was successfully completed.'
    else
      render :show, alert: 'Unable to complete task.'
    end
  end

  def changes
    if current_user == @task.client && @task.completed?
      @task.update(status: 'changes_requested')
      redirect_to @task, notice: 'Change request has been sent to the freelancer.'
    else
      redirect_to @task, alert: 'You are not authorized to request changes for this task.'
    end
  end

  def submit_changes
    @task = Task.find(params[:id])
  
    # Ensure that only the assigned freelancer can submit changes
    if current_user == @task.freelancer
      # Assume you have a file field for the revised file in your form named :revised_file
      if params[:revised_file].present?
        @task.revised_file.attach(params[:revised_file])
        @task.update(status: 'completed') # Update the task status as needed
  
        redirect_to @task, notice: 'Your changes have been submitted successfully.'
      else
        redirect_to @task, alert: 'You must attach a file to submit changes.'
      end
    else
      redirect_to @task, alert: 'You are not authorized to perform this action.'
    end
  end
  

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :budget, :deadline, :category, :status, :client_id, :freelancer_id, :completed_file)
  end
end
