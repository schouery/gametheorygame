#Game given by a matrix with two players. The entries of the matrix are
#represented by TwoPlayerMatrixGamePayoff which contains the payoffs for the
#user according to the TwoPlayerMatrixGameStrategy chosen.
class TwoPlayerMatrixGame < ActiveRecord::Base
  #Includes the BaseGame for commom game functionality
  include GameTheory::BaseGame
  has_many :strategies, :class_name => "TwoPlayerMatrixGameStrategy",
    :foreign_key => "game_id", :dependent => :destroy
  has_many :payoffs, :class_name => "TwoPlayerMatrixGamePayoff",
    :foreign_key => "game_id", :dependent => :destroy
  accepts_nested_attributes_for :strategies, :allow_destroy => true
  accepts_nested_attributes_for :payoffs, :allow_destroy => true
  before_create :associate_payoffs

  #The number of players is fixed in 2
  def number_of_players
    2
  end

  #Helper method for finding the strategies for the lines player, in this case,
  #the player number 1
  def lines_strategies
    self.strategies.select {|st| st.player_number == 1}
  end

  #Helper method for finding the strategies for the columns player, in this
  #case, the player number 2
  def columns_strategies
    self.strategies.select {|st| st.player_number == 2}
  end

  #Associate all payoffs to the corresponding strategies using its line and
  #column position
  def associate_payoffs
    self.payoffs.each do |payoff|
      payoff.strategy1 = self.lines_strategies.find do |strategy|
        strategy.number == payoff.line_position
      end if payoff.strategy1.nil?
      payoff.strategy2 = self.columns_strategies.find do |strategy|
        strategy.number == payoff.column_position
      end if payoff.strategy2.nil?
    end
  end

  #Returns the strategies avaliable to a specific user
  def strategies_for_player(index)
    if index == 1
      self.lines_strategies
    elsif index == 2
      self.columns_strategies
    else
      nil
    end
  end

  #Play the game when there is two cards with diferent player numbers and that
  #were played by diferent users.
  def play
    players_cards = valid_cards
    return if players_cards.nil?
    payoff = self.payoffs.find(:first,
      :conditions => {:strategy1_id => players_cards[0].strategy.id,
      :strategy2_id => players_cards[1].strategy.id})
    players_cards[0].play(payoff.payoff_player_1)
    players_cards[1].play(payoff.payoff_player_2)
    GameResult.create(:cards => players_cards, :game => self)
  end

  #Returns a matrix where each cell contains the payoff of the relative position
  def payoff_matrix
    lines, columns = self.lines_strategies.size, self.columns_strategies.size
    payoffs = create_matrix(lines, columns)
    self.payoffs.sort.each_with_index do |payoff, index|
      payoffs[index/columns][index%columns] = payoff
    end
    payoffs
  end

  #Setups the strategies and payoffs
  def initial_setup
    setup_strategies
    setup_payoffs
  end

  #Creates four strategy, two for each player and assigns then the player number
  #and number (that is, its position on the line or column)
  def setup_strategies
    4.times {self.strategies.build}
    self.strategies.each_with_index do |strategy, index|
      strategy.player_number = 1 + (index/2)
      strategy.number = index%2
    end
  end

  #Creates one payoff for each combination os line and column strategy.
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

  #Returns a matrix where each cell contains the percentage of times that this
  #line and column were chosen by the players.
  def results_matrix
    counter = create_matrix(self.lines_strategies.size,
      self.columns_strategies.size, 0)
    sum = self.game_results.size
    self.game_results.each do |result|
      sorted_cards = result.cards.sorted_by_player_number
      line = sorted_cards[0].strategy.number
      column = sorted_cards[1].strategy.number
      counter[line][column] += 1.0/sum
    end
    counter
  end
  
  private
  #Returns a array with two cards played with diferent users and diferent player
  #number sorted by player number. If there isn't such array, then returns nil.
  def valid_cards
    cards = played_cards
    player_1_cards = cards_with_uniq_users(cards.select do |card|
        card.player_number == 1
      end)
    player_2_cards = cards_with_uniq_users(cards.select do |card|
        card.player_number == 2
      end)
    player_1_cards.each do |player_1_card|
      player_2_cards.each do |player_2_card|
        if player_1_card.user != player_2_card.user
          return [player_1_card, player_2_card]
        end
      end
    end
    return nil
  end

  #Creates a matrix with "lines" lines and "columns" columns and with the
  #default value of a cell as "default"
  def create_matrix(lines, columns, default = nil)
    matrix = Array.new
    lines.times {matrix << Array.new(columns, default)}    
    matrix
  end
end