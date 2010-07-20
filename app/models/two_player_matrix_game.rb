class TwoPlayerMatrixGame < ActiveRecord::Base
  include GameTheory::BaseGame
  has_many :strategies, :class_name => "TwoPlayerMatrixGameStrategy", :foreign_key => "game_id", :dependent => :destroy
  has_many :payoffs, :class_name => "TwoPlayerMatrixGamePayoff", :foreign_key => "game_id", :dependent => :destroy
  accepts_nested_attributes_for :strategies
  accepts_nested_attributes_for :payoffs
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
  
  def fill_positions
    lines, columns = self.lines_strategies, self.columns_strategies
    s = sorted_payoffs(lines, columns)
    s.each_with_index do |payoff, k|
      payoff.line_position = k/columns.size
      payoff.column_position = k%columns.size
    end
    lines.each_with_index do |strategy, i|
      strategy.number = i
    end      
    columns.each_with_index do |strategy, i|
      strategy.number = i
    end      
  end
  
  def associate_payoffs
    self.payoffs.each do |payoff|
      payoff.strategy1 = self.lines_strategies.find {|s| s.number == payoff.line_position } if payoff.strategy1.nil?
      payoff.strategy2 = self.columns_strategies.find {|s| s.number == payoff.column_position } if payoff.strategy2.nil?
    end
  end
  
  def strategies_for_player(i)
    if i == 1
      self.lines_strategies
    elsif i == 2
      self.columns_strategies
    else
      nil
    end
  end
  
  def play
    cards = played_cards
    players_cards = []
    2.times do |i|
      players_cards << cards.find {|card| card.player_number == i+1}
    end
    return if players_cards[0].nil? || players_cards[1].nil?
    payoff = self.payoffs.find(:first) do |p|
      p.strategy1.id == players_cards[0].strategy.id && p.strategy2.id == players_cards[1].strategy.id
    end
    update_card(players_cards[0], payoff.payoff_player_1)
    update_card(players_cards[1], payoff.payoff_player_2)
    result = GameResult.new
    result.cards = players_cards
    result.game = self
    result.save
  end
    
  def payoff_matrix
    payoffs = []
    lines, columns = self.lines_strategies, self.columns_strategies
    lines.size.times {payoffs << Array.new(columns.size)}    
    s = sorted_payoffs(lines, columns)
    s.each_with_index do |payoff, k|
      payoffs[k/columns.size][k%columns.size] = payoff
    end      
    payoffs
  end

  def initial_setup
    setup_strategies
    setup_payoffs
  end
 
  def setup_strategies
    4.times {self.strategies.build}
    self.strategies.each_with_index do |strategy, i|
      strategy.player_number = 1 + (i/2)
      strategy.number = i%2
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
    counter = []
    lines, columns = self.lines_strategies, self.columns_strategies
    lines.size.times {counter << Array.new(columns.size, 0)}    
    sum = self.game_results.size
    self.game_results.each do |result|
      i = lines.index(result.sorted_cards[0].strategy)
      j = columns.index(result.sorted_cards[1].strategy)
      counter[i][j] += 1.0/sum
    end
    counter
  end

 
 private  
  def sorted_payoffs(lines, columns)
    self.payoffs.sort do |a, b|
      if (lines.index(a.strategy1) < lines.index(b.strategy1)) || 
         (lines.index(a.strategy1) == lines.index(b.strategy1) && columns.index(a.strategy2) < columns.index(b.strategy2))
        -1
      elsif lines.index(a.strategy1) == lines.index(b.strategy1) && columns.index(a.strategy2) == columns.index(b.strategy2)
        0
      else
        1
      end
    end  
  end
end
