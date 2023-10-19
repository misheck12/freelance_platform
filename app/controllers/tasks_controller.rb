class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :new_request_changes, :create_request_changes, :accept]

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
    @task.client = current_user
    @task.status = 'open' # or whatever status signifies a new task
  
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

  def accept
    if current_user.freelancer? && @task.open?
      @task.update(freelancer: current_user, status: :in_progress)
      redirect_to @task, notice: 'Task has been accepted!'
    else
      redirect_to @task, alert: 'You cannot accept this task!'
    end
  end

  def complete
    if @task.freelancer == current_user && @task.in_progress?
      if @task.update(task_params.merge(status: "completed"))
        redirect_to @task, notice: 'Task was successfully completed.'
      else
        render :show, alert: 'Unable to complete task.'
      end
    else
      redirect_to @task, alert: 'Not authorized to complete this task!'
    end
  end

  def create_request_changes
    @change_request = @task.change_requests.new(change_request_params)
    @change_request.requester = current_user
  
    if @change_request.save
      redirect_to @task, notice: 'Change request was successfully submitted.'
    else
      flash.now[:alert] = 'Unable to submit your request. Please try again.'
      render :show
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
    params.require(:task).permit(:title, :description, :budget, :deadline, :attachment, :client_id, :freelancer_id, :completed_file)
  end

  def change_request_params
    params.require(:change_request).permit(:content) # replace :content with your actual attributes
  end
end
