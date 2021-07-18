class ReviewsController < ApplicationController
  # before_action :login_required

  def index
    if params[:drink_id] && @drink = Drink.find_by_id(params[:drink_id])
      @reviews = @drink.reviews
    else
      flash.now[:danger] = "We don't have that booze!" if params[:drink_id]
      @reviews = Review.all
    end
  end

  def new
    if params[:drink_id] && @drink = Drink.find_by_id(params[:drink_id])
      @review = @drink.reviews.build
    else
      flash.now[:danger] = "We don't have that booze!" if params[:drink_id]
      @review = Review.new
    end
  end

  # def show
  #   @review - Review.find(id: params[:id])
  # end

  def create
    @review = current_user.reviews.build(review_params(:drink_id, :content, :status))
    if @review.save
      flash[:success] = "Review created!"
      redirect_to reviews_path
    else
      render :new
    end
    # @review = current_user.reviews.build(review_params(:drink_id, :content, :status))
    # if @review.save
    #   flash[:success] = "Review created!"
    #   redirect_to drink_reviews_path(@drink)
    # else
    #   render :new
    # end
  end

  def show
    review_found
  end

  private

  def review_params(*args)
    params.require(:review).permit(*args)
  end

  def review_found
    @review = Review.find_by(id: params[:id])
  end
end
