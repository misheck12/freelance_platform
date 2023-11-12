class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:new, :create]

  def new
    # Initialize a new payment for the task
    @payment = Payment.new
  end

  def create
    # Build a payment associated with the current user and the task
    @payment = Payment.new(payment_params)
    @payment.task = @task
    @payment.user = current_user

    if @payment.save
      redirect_to task_path(@task), notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def payment_params
    params.require(:payment).permit(:transaction_id, :status, :payment_proof, :user_id)
  end
  
end
