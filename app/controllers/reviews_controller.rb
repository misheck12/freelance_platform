class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:new, :create]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @review = @task.reviews.build # Initializes a review for the given task
  end

  def create
    @review = @task.reviews.build(review_params)
    @review.reviewer_id = current_user.id # Sets the reviewer to the current user

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
    task = @review.task # Store the associated task before destroying the review
    @review.destroy
    redirect_to task, notice: 'Review was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
