class DrinksController < ApplicationController
  before_action :login_required

  def index
    @drinks = Drink.all
  end

  def new
    @drink = Drink.new
  end

  def show
    drink_found
    redirect_to drinks_path if !@drink
  end

  def create
    @drink = current_user.drinks.build(drink_params(:name, :description, :rating))
    if @drink.save
      flash[:success] = "Added a new drink"
      redirect_to drinks_path
    else
      render :new
    end
  end

  private

  def drink_params(*args)
    params.require(:drink).permit(*args)
  end

  def drink_found
    @drink = Drink.find(params[:id])
  end
end
