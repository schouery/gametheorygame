class TwoPlayerMatrixGame < ActiveRecord::Base
  validates_presence_of :name, :description, :color
  validates_inclusion_of :color, :in => %w( red green yellow )
  has_many :strategies, :class_name => "TwoPlayerMatrixGameStrategy", :foreign_key => "game_id", :dependent => :destroy
  has_many :payoffs, :class_name => "TwoPlayerMatrixGamePayoff", :foreign_key => "game_id", :dependent => :destroy
  accepts_nested_attributes_for :strategies
  accepts_nested_attributes_for :payoffs
  has_many :cards, :as => :game

  def lines_strategies
    self.strategies.select {|st| st.player_number == 1}
  end
    
  def columns_strategies
    self.strategies.select {|st| st.player_number == 2}
  end
  
  def associate_payoffs
    self.payoffs.each do |payoff|
      payoff.strategy1 = self.lines_strategies.find {|s| s.number == payoff.line_position }
      payoff.strategy2 = self.columns_strategies.find {|s| s.number == payoff.column_position }
    end
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
 
 private  
  def sorted_payoffs(lines, columns)
    logger.info "Payoffs: " + payoffs.size.to_s
    self.payoffs.sort do |a, b|
      if lines.index(a.strategy1) < lines.index(b.strategy1)
        -1
      elsif lines.index(a.strategy1) == lines.index(b.strategy1) && columns.index(a.strategy2) < columns.index(b.strategy2)
        -1
      elsif lines.index(a.strategy1) == lines.index(b.strategy1) && columns.index(a.strategy2) == columns.index(b.strategy2)
        0
      else
        1
      end
    end  
  end
  
end
