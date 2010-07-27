#Helper for Item's Views
module ItemsHelper
  #Finds a item that was not used in a items collection
  def not_used(items)
    items.find do |item|
      !item.used?
    end
  end

  #Status messages for a items collections. It returns a string telling the
  #number of items and their status (used or not)
  def items_status(items)    
    if items.empty?
      "You don't have it yet."
    elsif items.all? {|item| !item.used?}
      "#{pluralize(items.size, 'item')} not used"
    else
      "1 item used and #{pluralize(items.size-1, 'item')} not used"
    end    
  end

end
