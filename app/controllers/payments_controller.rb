class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:new, :create]
  before_action :set_payment, only: [:accept, :reject]

  def new
    @payment = Payment.new
  end

  def show
    @payment = Payment.find_by(id: params[:id])
    if @payment.nil?
      redirect_to root_path, alert: 'payment not found'
    end
  end # <--- add this end

  def create
    @payment = @task.build_payment(payment_params)
    @payment.user = current_user
    @payment.status = :pending
  
    # Set the client_id based on the user's role
    if current_user.client?
      @payment.client_id = current_user.id
    elsif current_user.freelancer? && @task.client_id.present?
      @payment.client_id = @task.client_id
    end
  
    if @payment.save
      redirect_to task_path(@task), notice: 'Payment was successfully submitted and is pending approval.'
    else
      render :new
    end
  end  

  def accept
    if @payment.update(status: :approved)
      redirect_to dashboard_path, notice: 'Payment was successfully approved.'
    else
      redirect_to dashboard_path, alert: 'Payment could not be approved.'
    end
  end

  def reject
    if @payment.update(status: :rejected)
      redirect_to dashboard_path, notice: 'Payment was successfully rejected.'
    else
      redirect_to dashboard_path, alert: 'Payment could not be rejected.'
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:transaction_id, :payment_proof)
  end
end
