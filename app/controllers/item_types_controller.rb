class ItemTypesController < ApplicationController
  before_filter :find_item_set

  def index
    @item_types = @item_set.item_types
    authorize! :read, ItemType.new
  end

  def new
    @item_type = @item_set.item_types.build
    authorize! :create, @item_type
  end

  def edit
    @item_type = @item_set.item_types.find(params[:id])
    authorize! :update, @item_type
  end

  def create
    @item_type = @item_set.item_types.build(params[:item_type])
    authorize! :create, @item_type
    if @item_type.save
      flash[:notice] = 'ItemType was successfully created.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "new"
    end
  end

  def update
    @item_type = @item_set.item_types.find(params[:id])
    authorize! :update, @item_type
    if @item_type.update_attributes(params[:item_type])
      flash[:notice] = 'ItemType was successfully updated.'
      redirect_to item_set_item_types_path(@item_set)
    else
      render :action => "edit"
    end
  end

  def delete
    @item_type = @item_set.item_types.find(params[:id])
    authorize! :delete, @item_type
    @item_type.destroy
    redirect_to(item_set_item_types_url)
  end
  
  private
  def find_item_set
    @item_set = ItemSet.find(params[:item_set_id])
  end

end
