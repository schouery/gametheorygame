#Controller used to List, Show, Create, Update and Delete ItemTypes
class ItemTypesController < ApplicationController
  #Before all methods, assigns @item_set as the current item_set
  #This happens because ItemTypes is a nested resource of ItemSet
  before_filter :find_item_set

  #Assigns @item_types as all item_types from the @item_set
  def index
    @item_types = @item_set.item_types
    authorize! :read, ItemType.new
  end

  #Assigns @item_type as a new ItemType for this @item_set
  def new
    @item_type = @item_set.item_types.build
    authorize! :create, @item_type
  end

  #Assings the requested item_type as @item_type
  def edit
    @item_type = @item_set.item_types.find(params[:id])
    authorize! :update, @item_type
  end

  #Creates a new ItemType and redirects to item_set_item_types_path(@item_set)
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

  #Updates the requested item_type and redirects to
  #item_set_item_types_path(@item_set)
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

  #Destrois the requested item_type and redirects to item_set_item_types_path
  def delete
    @item_type = @item_set.item_types.find(params[:id])
    authorize! :delete, @item_type
    @item_type.destroy
    redirect_to(item_set_item_types_path)
  end
  
  private
  #Assigns the requested item_set as @item_set
  def find_item_set
    @item_set = ItemSet.find(params[:item_set_id])
  end

end
