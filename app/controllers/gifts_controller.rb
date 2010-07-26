class GiftsController < ApplicationController

  def index
    @cards = current_user.cards.select {|card| card.can_send_as_gift?(current_user) }
    @items = current_user.items.not_used
  end
  
  def card
    @card = Card.find(params[:id])
    if !@card.can_send_as_gift?(current_user)
      flash[:notice] = "You can't send this card!"
      redirect_to(gifts_url)
    end
  end
  
  def send_card
    card = Card.find(params[:id])
    if !card.send_as_gift(current_user, params[:ids][0].to_i)
      flash[:notice] = "You can't send this card!"
    end
    redirect_to(gifts_url)
  end
  
  def receive_card
    card = Card.find(params[:id])
    if card.gift_for == current_user.facebook_id
      card.user = current_user
      card.gift_for = nil
      card.save_without_validation
    end
    redirect_to(cards_url)
  end

  def item
    @item = Item.find(params[:id])
    if !@item.can_send_as_gift?(current_user)
      flash[:notice] = @item.gift_error
      redirect_to(gifts_url)
    end
  end
  
  def send_item
    item = Item.find(params[:id])
    if !item.send_as_gift(current_user, params[:ids][0].to_i)
      flash[:notice] = item.gift_error
    end
    redirect_to(gifts_url)
  end
  
  def receive_item
    item = Item.find(params[:id])
    if item.gift_for == current_user.facebook_id
      item.user = current_user
      item.gift_for = nil
      item.save
    end
    redirect_to(cards_url)
  end

  def money
  end

  def send_money
    if current_user.max_money_gifts > params[:ids].size
      MoneyGift.create_for(params[:ids], current_user)
      redirect_to(gifts_url)
    else
      flash[:notice] = "Action failed: You can't send so many gifts"
      render :money
    end
  end
  
  def receive_money
    money = MoneyGift.find(:first, :conditions => {:facebook_id => current_user.facebook_id})
    current_user.money += money.value
    current_user.save
    money.destroy
    redirect_to(cards_url)
  end
end