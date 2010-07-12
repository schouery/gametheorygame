class GiftsController < ApplicationController

  def index
    @cards = current_user.cards.select do |card|
      card.can_send?
    end
    @items = current_user.items.select do |item|
      !item.used
    end
  end
  
  def card
    @card = Card.find(params[:id])
    if !@card.can_send_as_gift?(current_user)
      flash[:notice] = @card.gift_error
      redirect_to(gifts_url)
    end
  end
  
  def send_card
    card = Card.find(params[:id])
    if !card.send_as_gift(current_user, params[:ids][0].to_i)
      flash[:notice] = card.gift_error
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
      flash[:notice] = "Action failed: You can't send so many gifts"
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
