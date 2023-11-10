class PaymentsController < ApplicationController
  before_action :set_task, only: [:new, :create]

  # GET /tasks/:task_id/payments/new
  def new
    @payment = @task.build_payment
  end

  # POST /tasks/:task_id/payments
  def create
    @payment = @task.build_payment(payment_params)

    if @payment.save
      redirect_to @task, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:task_id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:transaction_id, :amount, :status)
  end
end
