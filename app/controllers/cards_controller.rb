class CardsController < ApplicationController
  load_and_authorize_resource
  def index
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all do |card|
      card.strategy.nil?
    end
  end

  def played_cards
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all do |card|
      !card.strategy.nil?
    end    
  end

  def destroy
    @card.destroy
    redirect_to(cards_url)
  end
  
  def edit
    @partial = @card.game_type.underscore.pluralize + "/card"
  end

  def update
    if @card.update_attributes(params[:card])
      flash[:notice] = 'Card was successfully updated.'
      @card.game.play
      redirect_to(cards_url)
    else
      render :action => "edit"
    end
  end

end
