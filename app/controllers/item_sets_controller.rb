class ItemSetsController < ApplicationController
  load_and_authorize_resource
  def index
    @item_sets = ItemSet.all
  end

  def new
    @item_set.bonus_type = "hand_limit"
  end

  def edit
  end

  def create
    if @item_set.save
      flash[:notice] = 'ItemSet was successfully created.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "new"
    end
  end

  def update
    if @item_set.update_attributes(params[:item_set])
      flash[:notice] = 'ItemSet was successfully updated.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "edit"
    end
  end

  def delete
    @item_set.destroy
    redirect_to item_sets_path
  end
end
