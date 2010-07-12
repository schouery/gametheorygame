class ItemTypesController < ApplicationController
  before_filter :find_item_set

  def index
    @item_types = @item_set.item_types
  end

  def show
    @item_type = @item_set.item_types.find(params[:id])
  end

  def new
    @item_type = @item_set.item_types.build
  end

  def edit
    @item_type = @item_set.item_types.find(params[:id])
  end

  def create
    @item_type = @item_set.item_types.build(params[:item_type])
    if @item_type.save
      flash[:notice] = 'ItemType was successfully created.'
      redirect_to item_set_item_type_path(@item_set, @item_type)
    else
      render :action => "new"
    end
  end

  def update
    @item_type = @item_set.item_types.find(params[:id])
    if @item_type.update_attributes(params[:item_type])
      flash[:notice] = 'ItemType was successfully updated.'
      redirect_to item_set_item_type_path(@item_set, @item_type)
    else
      render :action => "edit"
    end
  end

  def destroy
    @item_type = @item_set.item_types.find(params[:id])
    @item_type.destroy
    redirect_to(item_set_item_types_url)
  end
  
 private
  def find_item_set
    @item_set = ItemSet.find(params[:item_set_id])
  end

end
