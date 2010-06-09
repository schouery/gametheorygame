class GiftsController < ApplicationController

  def index
    @cards = current_user.cards.select do |card|
      card.can_send?
    end
  end
  
  def card
    @card = Card.find(params[:id])
  end
  
  def send_card
    card = Card.find(params[:id])
    if card.can_send?
      card.user = nil
      card.gift_for = params[:ids][0].to_i
      card.save
    else
      flash[:notice] = "You can't send this card!"
    end
    redirect_to(gifts_url)
  end
  
  def receive_card
    card = Card.find(params[:id])
    if card.gift_for == current_user.facebook_id
      card.user = current_user
      card.gift_for = nil
      card.save
    end
    redirect_to(cards_url)
  end

  def money
  end

  def send_money
    ids = params[:ids]
    user = current_user
    value = Configuration[:money_gift_value]
    if user.max_money_gifts > ids.size
      ids.each do |id|
        MoneyGift.create(:facebook_id => id, :value => value)
      end
      user.money -= ids.size * value
      user.save
      redirect_to(gifts_url)
    else
      flash[:notice] = "Action failed: You didn't have enough money when creating the requested gifts"
      render :money
    end
  end
  
  def receive_money
    user = current_user
    facebook_id = user.facebook_id
    money = MoneyGift.find(:first, :conditions => {:facebook_id => facebook_id})
    if !money.nil? && facebook_id == money.facebook_id
      user.money += money.value
      user.save
      money.destroy
    end
    redirect_to(cards_url)
  end

end
