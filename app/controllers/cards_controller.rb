class CardsController < ApplicationController
  load_and_authorize_resource
  
  #Lists all game cards (as @cards) and item cards (as @items) of the current_user that wasn't used yet.
  def index
    @cards = Card.find(:all, :conditions => {:user_id => current_user.id, :played => false})
    @items = Item.find(:all, :conditions => {:user_id => current_user.id, :used => false})
  end

  #Lists all game cards played by current_user as @cards.
  def played_cards
    @cards = Card.find(:all, :conditions => {:user_id => current_user.id, :played => true})
  end

  #Define @card to the card with id equal to params[:id].
  def result
    @card = Card.find(params[:id])
  end

  #Destroy a card.
  def discard
    @card.destroy
    redirect_to(cards_url)
  end
  
  #Used to play a card.
  #It defines @card to the card with id equal to params[:id] and @partial as a path to be render to show the game informations
  #and strategies avaliable to a user
  def edit
    if @card.played?
      redirect_to(cards_url)
    else
      @partial = @card.game_type.underscore.pluralize + "/card"
    end
  end

  #Updates a card with the choosen strategy for the game.
  def update
    if !@card.played?
      @card.played = true
      if @card.update_attributes(params[:card])
        flash[:notice] = 'Card was successfully updated.'
        @card.game.play
        redirect_to(cards_url)
      else
        render :action => "edit"
      end
    else @card.played?
      flash[:notice] = 'That card was already played.'
      redirect_to(cards_url)
    end
  end
end