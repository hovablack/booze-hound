module DrinksHelper

  def drink_found
    @drink = Drink.find_by(params[:drink_id])
  end
end
