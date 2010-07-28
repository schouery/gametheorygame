#Represents a game where all players have the same strategies and the payoff is
#calculated by a function
class SymmetricFunctionGame < ActiveRecord::Base
  #Includes the BaseGame for commom game functionality
  include GameTheory::BaseGame
  validates_presence_of :function, :number_of_players
  validates_numericality_of :number_of_players, :only_integer => true,
    :greater_than => 0
  has_many :strategies, :class_name => "SymmetricFunctionGameStrategy",
    :dependent => :destroy, :foreign_key => :game_id
  #Destroy the strategies when been destroyed
  accepts_nested_attributes_for :strategies, :allow_destroy => true

  #Play the game when there is enough cards. Note that it can't happen to have
  #more cards (with uniq users) than the number of players, because we always
  #call play when a card is played
  def play
    cards = cards_with_uniq_users(played_cards)
    return if cards.size < self.number_of_players
    np = strategy_histogram(cards)
    cards.each {|card| card.play(calculate(strategies_for(card), np))}
    GameResult.create(:cards => cards, :game => self)
  end

  #Returns a hash where the keys are the strategies and the values are the
  #ratio between the number of times the strategy was chosen and the number of
  #cards played
  def strategies_percentages
    sum = self.number_of_players * self.game_results.size
    histogram = Hash.new(0)
    self.game_results.each do |result|
      result.cards.each do |card|
        histogram[card.strategy] += 1.0 / sum
      end
    end
    histogram
  end

  private
  #Evaluate the function where st[i] is 1 if the strategy i was chosen by this
  #player and 0 otherwise and np[j] is the number of players that chosen
  #strategy j.
  def calculate(st, np)
    eval(self.function)
  end

  #Returns a array with the number of players that chosen strategy i
  def strategy_histogram(cards)
    Array.new(self.strategies.size) do |index|
      cards.inject(0) do |acc, card|
        acc += (self.strategies[index] == card.strategy) ? 1 : 0;  
      end
    end    
  end

  #Returns a array where position i is 1 if the strategy i is the strategy of
  #this card and 0 otherwise.
  def strategies_for(card)
    Array.new(self.strategies.size) do |index|
      (self.strategies[index] == card.strategy) ? 1 : 0;
    end
  end
end