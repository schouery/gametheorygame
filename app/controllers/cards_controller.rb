class CardsController < ApplicationController
  load_and_authorize_resource
  
  def index
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all { |card| !card.played? } unless all_cards.nil?
    @items = Item.find(:all, :conditions => {:user_id => current_user.id, :used => false})
  end

  def played_cards
    all_cards = Card.find(:all, :conditions => {:user_id => current_user.id})
    @cards = all_cards.find_all do |card|
      card.played?
    end    
  end

  def result
    @card = Card.find(params[:id])
  end

  def discard
    @card.destroy
    redirect_to(cards_url)
  end
  
  def edit
    if @card.played?
      redirect_to(cards_url)
    else
      @partial = @card.game_type.underscore.pluralize + "/card"
    end
  end

  def update
    if !@card.played? && @card.update_attributes(params[:card])
      flash[:notice] = 'Card was successfully updated.'
      @card.game.play
      redirect_to(cards_url)
    elsif @card.played?
      flash[:notice] = 'That card was already played.'
      redirect_to(cards_url)
    else
      render :action => "edit"
    end
  end

end
