#Controller for item actions
class ItemsController < ApplicationController

  #Assigns a hash contain ItemSets, ItemTypes and Items for current_user as
  #@user_sets. You should read the documentation on ItemSet::sets_for
  def index
    @user_sets = ItemSet.sets_for(current_user)
  end

  #Assigns the requested item as @item and it's item type and item set as
  #@item_type and @item_set
  def show
    @item = Item.find(params[:id])
    authorize! :read, @item
    @item_type = @item.item_type unless @item.nil?
    @item_set = @item_type.item_set unless @item_type.nil?
  end

  #Marks the requested item as used and redirects to cards_path
  def use
    @item = Item.find(params[:id])
    authorize! :use, @item
    @item.use
    redirect_to cards_path, :notice => "Item used."
  end

end
