class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task

  def new
    @payment = Payment.new # Initializes a new payment
  end

  def create
    @payment = @task.payments.build(payment_params) # Builds a payment associated with the task
    @payment.user = current_user # Assigns the current user to the payment

    if @payment.save
      redirect_to @task, notice: 'Payment was successfully recorded.'
    else
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id]) # Finds the task based on the passed task_id
  end

  def payment_params
    params.require(:payment).permit(:transaction_id, :payment_proof, :status)
    # Ensure :payment_proof is set up to handle file uploads if it's a file field
  end
end
