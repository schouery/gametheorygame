class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all.select do |auction|
      auction.end_date.future?
    end
  end
  
  def specific
    @item_type = ItemType.find(params[:id]) 
    items = @item_type.items.select do |item|
      !item.auction.nil? && item.auction.end_date.future?
    end
    @auctions = items.collect {|item| item.auction }
  end

  def active
    all_actions = Auction.find(:all, :conditions => {:user_id => current_user.id})
    @auctions = all_actions.select {|auction| auction.end_date.future?}
  end

  def new
    @item = Item.find(params[:item_id])
    if !@item.auction.nil?
      redirect_to cards_path, :notice => 'This item is already in auction.'
    elsif @item.user != current_user
      redirect_to cards_path, :notice => "This item isn't yours."
    else
      @auction = Auction.new
      @auction.end_date = 1.day.from_now
      @auction.item = @item      
    end
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def create
    @auction = Auction.new(params[:auction])
    @item = @auction.item
    @auction.user = @item.user
    if @auction.save
      @item.user = nil
      @item.save
      redirect_to cards_path, :notice => 'Auction was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.make_a_bid(params[:auction], current_user)
      redirect_to auctions_path, :notice => 'Auction was successfully updated.'
    else
      flash[:notice] = @auction.error unless @auction.error.nil?
      render :action => "edit"
    end
  end
 
end
