class User < ActiveRecord::Base
  has_many :cards

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end

  def payoff
    p = 0
    self.cards.each do |card|
      p += card.payoff if !card.payoff.nil?
    end
    p
  end

end
