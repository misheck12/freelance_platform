json.extract! payment, :id, :user_id, :task_id, :transaction_id, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)
