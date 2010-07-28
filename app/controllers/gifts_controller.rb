#Controller used to send gifts to friends
class GiftsController < ApplicationController

  #Lists all cards (as @cards) and all items (as @items) that can be sended
  def index
    @cards = current_user.cards.select do |card|
      card.can_send_as_gift?(current_user)
    end
    @items = current_user.items.not_used
  end

  #Assign @card as the requested card, used for sending a card
  def card
    @card = Card.find(params[:id])
    if !@card.can_send_as_gift?(current_user)
      flash[:notice] = "You can't send this card!"
      redirect_to(gifts_path)
    end
  end

  #Sends a card and redirects to gits_path
  def send_card
    card = Card.find(params[:id])
    if !card.send_as_gift(current_user, params[:ids][0].to_i)
      flash[:notice] = "You can't send this card!"
    end
    redirect_to(gifts_path)
  end

  #Gives a card to the current_user and redirects to cards_path
  #bypassing canvas (to avoid nested frames)
  def receive_card
    card = Card.find(params[:id])
    if card.gift_for == current_user.facebook_id
      card.user = current_user
      card.gift_for = nil
      card.save_without_validation
    end
    redirect_to(:action => "index", :controller => "cards", 
      :bypass_canvas => true)
  end

  #Assign @item as the requested item, used for sending a item
  def item
    @item = Item.find(params[:id])
    if !@item.can_send_as_gift?(current_user)
      flash[:notice] = "You can't send this item!"
      redirect_to(gifts_path)
    end
  end

  #Sends a item and redirects to gifts_path
  def send_item
    item = Item.find(params[:id])
    if !item.send_as_gift(current_user, params[:ids][0].to_i)
      flash[:notice] = "You can't send this item!"
    end
    redirect_to(gifts_path)
  end

  #Gives a item to the current_user and redirects to cards_path
  #bypassing canvas (to avoid nested frames)
  def receive_item
    item = Item.find(params[:id])
    if item.gift_for == current_user.facebook_id
      item.user = current_user
      item.gift_for = nil
      item.save
    end
    redirect_to(:action => "index", :controller => "cards", 
      :bypass_canvas => true)
  end

  #Money action, used to select friends to receive money gifts
  def money
  end

  #Sends money gifts to selected friends and redirects to gifts_path
  #The friend's ids are given by params[:ids]
  def send_money
    if current_user.max_money_gifts > params[:ids].size
      MoneyGift.create_for(params[:ids], current_user)
      redirect_to(gifts_path)
    else
      flash[:notice] = "You can't send so many gifts"
      render :money
    end
  end

  #Receive a money gift and redirects to cards_path bypassing canvas
  #(to avoid nested frames)
  def receive_money
    money = MoneyGift.find(:first,
      :conditions => {:facebook_id => current_user.facebook_id})
    current_user.money += money.value
    current_user.save
    money.destroy
    redirect_to(:action => "index", :controller => "cards", 
      :bypass_canvas => true)
  end
end