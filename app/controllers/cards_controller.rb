class CardsController < ApplicationController

  def index
    @cards = Card.find(:all, :conditions => {:user_id => current_user.id})
  end

  def show
    @card = Card.find(params[:id])
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to(cards_url)
  end
end
