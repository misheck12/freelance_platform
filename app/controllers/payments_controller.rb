# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :set_task, only: [:new, :create]

  def new
    @payment = @task.payments.new
  end

  def create
    @payment = @task.payments.new(payment_params)
    if @payment.save
      redirect_to @task, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def payment_params
    params.require(:payment).permit(:transaction_id, :payment_proof)
  end
end
