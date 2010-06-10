class GiftLog < ActiveRecord::Base
  belongs_to :user
  
  def can_send(type, number)
    gifts_today(type) + number <= Configuration["#{type}_gift_limit"]
  end

  def gifts_today(type)
    send("#{type}_gift_sent_on") == Date.today ? send("number_of_#{type}_gifts") : 0
  end

  def log(type, number = 1)
    send("number_of_#{type}_gifts=", gifts_today(type) + number)
  end
  
end
