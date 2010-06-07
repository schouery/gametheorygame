class GiftsController < ApplicationController

  def index
    @cards = current_user.cards.select do |card|
      card.game.color == "green" && !card.played?
    end
  end
  
  def card
  end
  
  def send_card
    card = Card.find(params[:card_id])
    card.user = nil
    card.gift_for = params[:id].to_i
    card.save
    redirect_to(gifts_url)
  end
  
  def receive_card
    card = Card.find(params[:id])
    if card.gift_for == current_user.facebook_id
      card.user = current_user.id
      card.gift_for = nil
      card.save
    end
    redirect_to(cards_url)
  end

  def money
  end

  def send_money
    params[:ids].each do |id|
      MoneyGift.create(:facebook_id => id, :value => 100)
    end
    current_user.money -= params[:ids].size * 100
    current_user.save
    redirect_to(gifts_url)
  end

  def receive_money
    m = MoneyGift.find(:first, :conditions => {:facebook_id => current_user.facebook_id})
    if !m.nil? && current_user.facebook_id == m.facebook_id
      current_user.money += m.value
      current_user.save
      m.destroy
    end
    redirect_to(cards_url)
  end

end
