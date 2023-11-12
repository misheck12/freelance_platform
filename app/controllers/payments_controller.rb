class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:new, :create]

  def new
    # Initialize a new payment for the task
    @payment = Payment.new
  end

  def create
    @payment = @task.build_payment(payment_params)
    
    # Make sure that current_user is not nil
    if current_user.nil?
      return redirect_to new_user_session_path, alert: 'You must be signed in to make a payment.'
    end
    
    @payment.user = current_user
  
    if @payment.save
      redirect_to task_path(@task), notice: 'Payment was successfully created.'
    else
      render :new
    end
  end
  
  private
  
  def payment_params
    params.require(:payment).permit(:transaction_id, :payment_proof, :status)
  end
  

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def payment_params
    params.require(:payment).permit(:transaction_id, :status, :payment_proof, :user_id)
  end
  
end
