module ItemsHelper

  def not_used(items)
    items.find do |item|
      !item.used?
    end
  end
  
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
