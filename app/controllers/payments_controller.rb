class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:new, :create]
  before_action :set_payment, only: [:show, :accept, :reject]

  def new
    @payment = Payment.new
  end

  def create
    @payment = @task.build_payment(payment_params)
    set_payment_user_and_status

    if @payment.save
      redirect_to task_path(@task), notice: 'Payment was successfully submitted and is pending approval.'
    else
      render :new
    end
  end

  def show
    if @payment.nil?
      redirect_to root_path, alert: 'Payment not found'
    else
      set_payment_user_and_status
    end
  end

  def accept
    authorize_payment_action(:accept, :approved)
  end

  def reject
    authorize_payment_action(:reject, :rejected)
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

  def set_payment_user_and_status
    @payment.user = current_user
    @payment.client_id = current_user.id if current_user.client?
    @payment.freelancer_id = current_user.id if current_user.freelancer?
    @payment.status = :pending  # Assuming the status enum includes pending
  end

  def authorize_payment_action(action, status)
    if @payment.update(status: status)
      redirect_to dashboard_path, notice: "Payment was successfully #{action.to_s.humanize}."
    else
      redirect_to dashboard_path, alert: "Payment could not be #{action.to_s.humanize.downcase}."
    end
  end
end
