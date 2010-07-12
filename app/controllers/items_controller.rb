class ItemsController < ApplicationController

   def index
     @user_sets = ItemSet.sets_for(current_user)
   end

   def show
     @item = Item.find(params[:id])
     @item_type = @item.item_type unless @item.nil?
     @item_set = @item_type.item_set unless @item_type.nil?
   end
   
   def use
     @item = Item.find(params[:id])
     @item.use
     redirect_to cards_path, :notice => "Item used."
   end

end
