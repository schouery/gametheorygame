class GiftsController < ApplicationController

  def index
    @cards = current_user.cards.select do |card|
      card.color == "green" && !card.played?
    end
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
    m = MoneyGift.find(params[:id])
    if current_user.facebook_id == m.facebook_id
      current_user.money += m.value
      current_user.save
      m.destroy
    end
    redirect_to(cards_url)
  end

end
