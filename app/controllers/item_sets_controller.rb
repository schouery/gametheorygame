#Controller used to List, Show, Create, Update and Delete ItemSets
class ItemSetsController < ApplicationController
  #CanCan helper method, assigns @item_set in (almost) methods
  load_and_authorize_resource

  #Lists all ItemSets
  def index
    @item_sets = ItemSet.all
  end

  #Assings @item_set as a new ItemSet (but not saved).
  #By default, chooses the bonus_type as hand_limit.
  def new
    @item_set.bonus_type = "hand_limit"
  end

  #Assings the request item set as @item_set
  def edit
  end

  #Creates a new ItemSet and redirects to item_set_item_types_path(@item_set)
  def create
    if @item_set.save
      flash[:notice] = 'ItemSet was successfully created.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "new"
    end
  end

  #Updates a ItemSet and redirects to item_set_item_types_path(@item_set)
  def update
    if @item_set.update_attributes(params[:item_set])
      flash[:notice] = 'ItemSet was successfully updated.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "edit"
    end
  end

  #Destroy a ItemSet and redirects to item_sets
  def delete
    @item_set.destroy
    redirect_to item_sets_path
  end
end
