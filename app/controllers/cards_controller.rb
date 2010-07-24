class CardsController < ApplicationController
  load_and_authorize_resource
  
  #Lists all game cards (as @cards) and item cards (as @items) of the current_user that wasn't used yet.
  def index
    @cards = Card.not_played.all(:conditions => {:user_id => current_user.id})
    @items = Item.not_used.all(:conditions => {:user_id => current_user.id})
  end

  #Lists all game cards played by current_user as @cards.
  def played_cards
    @cards = Card.played.all(:conditions => {:user_id => current_user.id})
  end

  #Define @card to the card with id equal to params[:id].
  def result
  end

  #Destroy a card.
  def discard
    @card.destroy
    redirect_to(cards_url)
  end
  
  #Used to play a card.
  #It defines @card to the card with id equal to params[:id]
  def edit
    redirect_to(cards_url) if @card.played?
  end

  #Updates a card with the choosen strategy for the game.
  def update
    @card.played = true    
    if @card.update_attributes(params[:card])
      @card.game.play
      flash[:notice] = 'Card was successfully updated.'
      redirect_to(cards_url)
    else
      render :action => "edit"
    end
  end
end