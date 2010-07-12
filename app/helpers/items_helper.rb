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

end
