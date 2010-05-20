class User < ActiveRecord::Base
  has_many :cards

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end

  def payoff
    self.cards.inject(0) do |acc, card|
      (acc += card.payoff) if !card.payoff.nil?
    end
  end

end
