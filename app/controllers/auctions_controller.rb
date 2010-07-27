#Controller related to Auctions .
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
    @auctions = @item_type.items.map(&:auction).select do |auction|
      !auction.nil? && auction.end_date.future?
    end
  end

  #Lists all auctions with future end_date from current_user as @auctions
  def active
    @auctions = Auction.find_all_by_user_id(current_user.id).select do |auction|
      auction.end_date.future?
    end
  end

  #Creates a new auction for the item given by item_id
  #The auction has a end_date of 1 day from the creation time
  def new
    @item = Item.find(params[:item_id])
    authorize! :create_auction, @item
    if !@item.auction.nil?
      redirect_to cards_path, :notice => 'This item is already in auction.'
    else
      @auction = Auction.new(:end_date => 1.day.from_now, :item => @item)
    end
  end

  #Defines @auction as a auction with id equal to params[:id]
  def edit
    @auction = Auction.find(params[:id])
  end

  #Saves a auction on the databse and redirects to cards_path
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

  #Saves the updates of auction on the database  and redirects to cards_path.
  #Used for making bids on the auction
  def update
    @auction = Auction.find(params[:id])
    if @auction.make_a_bid(params[:auction], current_user)
      redirect_to auctions_path, :notice => 'Auction was successfully updated.'
    else
      flash[:notice] = @auction.error
      render :action => "edit"
    end
  end
 
end
