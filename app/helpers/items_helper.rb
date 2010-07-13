module ItemsHelper
  def item_class(item)
    if item.nil?
      "item_not_found"
    elsif item.used?
      "item_used"
    else
      "item_not_used"
    end
  end

  def item_status(item)
    if item.nil?
      "You don't have it yet."
    elsif item.used?
      "Used"
    else
      "Owned but not used"
    end    
  end

end
