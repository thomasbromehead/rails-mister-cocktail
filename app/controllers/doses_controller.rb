class DosesController < ApplicationController

  before_action :find_cocktail, only: [:new, :create]
  # You don't to add the "destroy" method if you haven't nested it, as it doesn't need the cocktail ID.

  def new
    @dose = Dose.new
    # @ingredients = []
    # Ingredient.all.each do |ing|
    #   @ingredients << ing.name
    # end
    @ingredient = Ingredient.all
  end
  
  def create
    @ingredients = []
    Ingredient.all.each do |ing|
      @ingredients << ing.name
    end
    @dose = Dose.new(dose_params)
    # Assign the dose's cocktail to be the cocktail found by the private method
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail_id)
    else 
      p '-----'
      puts @dose.errors.full_messages
      p '----'
      render 'new'
    end
  end

  def destroy
  # Retrieve the dose to be delete
  @dose = Dose.find(params[:id])
  @dose.destroy
  redirect_to root_path
  # Delete this dose 

  end

  private
  
  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def find_ingredient
    @ingredient = Ingredient.find(params[:ingredient_id])
  end

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end

