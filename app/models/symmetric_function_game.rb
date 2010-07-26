class SymmetricFunctionGame < ActiveRecord::Base
  include GameTheory::BaseGame
  validates_presence_of :function, :number_of_players
  validates_numericality_of :number_of_players, :only_integer => true, :greater_than => 0
  has_many :strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy, :foreign_key => :game_id
  accepts_nested_attributes_for :strategies, :allow_destroy => true
           
  def play
    cards = cards_with_uniq_users(played_cards)
    return if cards.size < self.number_of_players
    np = strategy_histogram(cards)
    cards.each {|card| card.play(calculate(strategies_for(card), np))}
    GameResult.create(:cards => cards, :game => self)
  end

  def strategies_percentages
    sum = self.number_of_players * self.game_results.size
    puts sum
    histogram = Hash.new(0)
    self.game_results.each do |result|
      result.cards.each do |card|
        histogram[card.strategy] += 1.0 / sum
      end
    end
    histogram
  end

  private
  def calculate(st, np)
    eval(self.function)
  end

  def strategy_histogram(cards)
    Array.new(self.strategies.size) do |index|
      cards.inject(0) do |acc, card|
        acc += (self.strategies[index] == card.strategy) ? 1 : 0;  
      end
    end    
  end

  def strategies_for(card)
    Array.new(self.strategies.size) do |index|
      (self.strategies[index] == card.strategy) ? 1 : 0;
    end
  end
end