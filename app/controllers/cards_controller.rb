class CardsController < ApplicationController

  def index
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all do |card|
      card.symmetric_function_game_strategy.nil?
    end
  end

  def played_cards
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all do |card|
      !card.symmetric_function_game_strategy.nil?
    end    
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to(cards_url)
  end
  
  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update_attributes(params[:card])
      flash[:notice] = 'Card was successfully updated.'
      @card.symmetric_function_game.play
      redirect_to(cards_url)
    else
      render :action => "edit"
    end
  end

end
