module GameTheory
  module BaseGame
    def self.included(base)
      base.extend(ClassMethods)  
    end
    def self.included(base)  
      base.has_many :cards, :as => :game
      base.has_many :game_scores, :as => :game
      base.has_many :game_results, :as => :game
      base.belongs_to :user
      base.validates_presence_of :name, :description, :color
      base.validates_inclusion_of :color, :in => ["red", "green", "yellow"]
      base.validates_numericality_of :weight, :only_integer => true, :greater_than => 0
    end
  
    module ClassMethods
    end

    def played_cards
      self.cards.find_all { |card| !card.strategy.nil? && card.payoff.nil? }
    end
    
    def update_card(card, payoff)
      card.payoff = payoff
      card.save
      player = card.user
      player.score += payoff
      player.save
      update_game_score(payoff, player)
    end

    def update_game_score(payoff, player)
      game_score = self.game_scores.find_by_user_id(player.id)
      if game_score.nil?
        game_score = GameScore.new
        game_score.user = player
        game_score.game = self
      end
      game_score.score += payoff
      game_score.save
    end
  end
end