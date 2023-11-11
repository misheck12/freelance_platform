class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task

  # GET /tasks/:task_id/payments/new
  def new
    # Initialize a new payment for the task
    @payment = @task.build_payment
  end

  # POST /tasks/:task_id/payments
  def create
    # Initialize a payment for the task with the current_user's id
    @payment = @task.build_payment(payment_params.merge(user_id: current_user.id))
  
    if @payment.save
      redirect_to @task, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end
  

  private

  # Set the task, ensuring it belongs to the current_user
  def set_task
    @task = current_user.tasks_as_client.find(params[:task_id])
  end

  # Define permitted parameters for payments
  def payment_params
    params.require(:payment).permit(:transaction_id, :payment_proof, :status, :user_id)
    # Ensure :payment_proof is the correct field for the file upload
  end
end
