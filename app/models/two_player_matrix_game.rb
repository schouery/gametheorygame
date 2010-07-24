class TwoPlayerMatrixGame < ActiveRecord::Base
  include GameTheory::BaseGame
  has_many :strategies, :class_name => "TwoPlayerMatrixGameStrategy", :foreign_key => "game_id", :dependent => :destroy
  has_many :payoffs, :class_name => "TwoPlayerMatrixGamePayoff", :foreign_key => "game_id", :dependent => :destroy
  accepts_nested_attributes_for :strategies, :allow_destroy => true
  accepts_nested_attributes_for :payoffs, :allow_destroy => true
  before_create :associate_payoffs
  
  def number_of_players
    2
  end

  def lines_strategies
    self.strategies.select {|st| st.player_number == 1}
  end
    
  def columns_strategies
    self.strategies.select {|st| st.player_number == 2}
  end
  
  def associate_payoffs
    self.payoffs.each do |payoff|
      payoff.strategy1 = self.lines_strategies.find {|strategy| strategy.number == payoff.line_position } if payoff.strategy1.nil?
      payoff.strategy2 = self.columns_strategies.find {|strategy| strategy.number == payoff.column_position } if payoff.strategy2.nil?
    end
  end
  
  def strategies_for_player(index)
    if index == 1
      self.lines_strategies
    elsif index == 2
      self.columns_strategies
    else
      nil
    end
  end
    
  def play
    players_cards = valid_cards
    return if players_cards.nil?
    payoff = self.payoffs.find(:first, :conditions => {:strategy1_id => players_cards[0].strategy.id, 
        :strategy2_id => players_cards[1].strategy.id})
    players_cards[0].play(payoff.payoff_player_1)
    players_cards[1].play(payoff.payoff_player_2)
    GameResult.create(:cards => cards, :game => self)
  end
    
  def payoff_matrix
    lines, columns = self.lines_strategies.size, self.columns_strategies.size
    payoffs = create_matrix(lines, columns)
    self.payoffs.sort.each_with_index do |payoff, index|
      payoffs[index/columns][index%columns] = payoff
    end
    payoffs
  end

  def initial_setup
    setup_strategies
    setup_payoffs
  end
 
  def setup_strategies
    4.times {self.strategies.build}
    self.strategies.each_with_index do |strategy, index|
      strategy.player_number = 1 + (index/2)
      strategy.number = index%2
    end
  end
  
  def setup_payoffs
    self.lines_strategies.each_with_index do |line_strategy, line|
      self.columns_strategies.each_with_index do |column_strategy, column|
        payoff = self.payoffs.build
        payoff.strategy1 = line_strategy
        payoff.strategy2 = column_strategy
        payoff.line_position = line
        payoff.column_position = column
      end
    end
  end

  def results_matrix
    counter = create_matrix(self.lines_strategies.size, self.columns_strategies.size, 0)
    sum = self.game_results.size
    self.game_results.each do |result|
      sorted_cards = result.cards.sorted_by_player_number
      counter[sorted_cards[0].strategy.number][sorted_cards[1].strategy.number] += 1.0/sum
    end
    counter
  end
  
  private
  def valid_cards
    cards = played_cards
    player_1_cards = cards_with_uniq_users(cards.select {|card| card.player_number == 1})
    player_2_cards = cards_with_uniq_users(cards.select {|card| card.player_number == 2})
    player_1_cards.each do |player_1_card|
      player_2_cards.each do |player_2_card|
        return [player_1_card, player_2_card] if player_1_card.user != player_2_card.user
      end
    end
    return nil
  end
  
  def create_matrix(lines, columns, default = nil)
    matrix = Array.new
    lines.times {matrix << Array.new(columns, default)}    
    matrix
  end
end