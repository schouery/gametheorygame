class ItemSetsController < ApplicationController
  def index
    @item_sets = ItemSet.all
  end

  def show
    @item_set = ItemSet.find(params[:id])
  end

  def new
    @item_set = ItemSet.new
    @item_set.bonus_type = "hand_limit"
  end

  def edit
    @item_set = ItemSet.find(params[:id])
  end

  def create
    @item_set = ItemSet.new(params[:item_set])
    if @item_set.save
      redirect_to(@item_set, :notice => 'ItemSet was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @item_set = ItemSet.find(params[:id])
    if @item_set.update_attributes(params[:item_set])
      redirect_to(@item_set, :notice => 'ItemSet was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @item_set = ItemSet.find(params[:id])
    @item_set.destroy
    redirect_to item_sets_path
  end
end
