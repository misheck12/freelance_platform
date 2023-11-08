class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :edit, :update, :destroy]
  
    def show
    end
  
    def new
      @review = Review.new
    end
  
    def create
      @review = Review.new(review_params)
      if @review.save
        redirect_to @review.task, notice: 'Review was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @review.update(review_params)
        redirect_to @review.task, notice: 'Review was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @review.destroy
      redirect_to @review.task, notice: 'Review was successfully destroyed.'
    end
  
    private

  def set_task
    @task = Task.find(params[:task_id]) # params[:task_id] should be provided in the URL
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
  