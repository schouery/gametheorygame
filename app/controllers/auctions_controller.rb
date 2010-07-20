class AuctionsController < ApplicationController

  #Lists all auctions with future end_date as @auctions
  def index
    @auctions = Auction.all.select do |auction|
      auction.end_date.future?
    end
  end
  
  #Lists all auctions from a specific ItemType
  #* @item_type is the ItemType with id equal to params[:id]
  #* @auctions are the auctions from this @item_type with future end_date
  def specific
    @item_type = ItemType.find(params[:id]) 
    items = @item_type.items.select do |item|
      !item.auction.nil? && item.auction.end_date.future?
    end
    @auctions = items.collect {|item| item.auction }
  end

  #Lists all auctions with future end_date from current_user as @auctions
  def active
    all_actions = Auction.find_all_by_user_id(current_user.id)
    @auctions = all_actions.select {|auction| auction.end_date.future?}
  end

  #Creates a new auction for the item given by item_id
  #The auction has a end_date of 1 day from the creation time
  def new
    @item = Item.find(params[:item_id])
    authorize! :create_auction, @item
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

  #Defines @auction as a auction with id equal to params[:id]
  def edit
    @auction = Auction.find(params[:id])
  end

  #Saves a auction on the databse
  def create
    @auction = Auction.new(params[:auction])
    @item = @auction.item
    authorize! :create_auction, @item
    @auction.user = @item.user
    if @auction.save
      @item.user = nil
      @item.save
      redirect_to cards_path, :notice => 'Auction was successfully created.'
    else
      render :action => "new"
    end
  end

  #Saves the updates of auction on the database
  #Used for making bids on the auction
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
