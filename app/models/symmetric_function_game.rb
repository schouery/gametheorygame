class SymmetricFunctionGame < ActiveRecord::Base
  has_many :cards, :as => :game
  has_many :game_results, :as => :game
  validates_presence_of :name, :description, :function, :color, :number_of_players
  validates_numericality_of :number_of_players, :only_integer => true, :greater_than => 0
  validates_inclusion_of :color, :in => ["red", "green", "yellow"]
  has_many :strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy, :foreign_key => :game_id
  accepts_nested_attributes_for :strategies
  
  def played_cards
    self.cards.find_all { |card| !card.strategy.nil? && card.payoff.nil? }
  end

  def play
    cards = played_cards
    return if cards.size < self.number_of_players
    np = strategy_histogram(cards)
    cards.each do |card|
      card.payoff = calculate(strategies_for(card), np)
      card.save
    end
    result = GameResult.new
    result.game = self
    result.cards = cards
    result.save
  end
  
  def strategies_percentages
    histogram = {}
    self.strategies.each do |strategy|
      histogram[strategy] = 0
    end
    sum = 2*self.game_results.size
    self.game_results.each do |result|
      result.cards.each do |card|
        histogram[card.strategy] += 1.0/sum
      end
    end
    histogram
  end

 private

  def calculate(st, np)
    eval(self.function)
  end

  def strategy_histogram(cards)
    Array.new(self.strategies.size) do |i|
      cards.inject(0) do |acc, card|
        acc += (self.strategies[i] == card.strategy) ? 1 : 0;  
      end
    end    
  end

  def strategies_for(card)
    Array.new(self.strategies.size) do |i|
      (self.strategies[i] == card.strategy) ? 1 : 0;
    end
  end
  
end
