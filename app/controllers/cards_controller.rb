class CardsController < ApplicationController

  def index
    @cards = Card.find(:all, :conditions => {:user_id => current_user.id})
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
      redirect_to(cards_url)
    else
      render :action => "edit"
    end
  end

end
