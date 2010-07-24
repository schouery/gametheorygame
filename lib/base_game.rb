#   
# if params[:type] == 'symmetric_function_game'
#   @game = SymmetricFunctionGame.find(params[:id])
# else
#   @game = TwoPlayerMatrixGame.find(params[:id])
# end


class Games
  def self.collect_results
    @game_classes.inject([]) do |sum, game_class|
      sum += yield(game_class)
    end
  end
  
  def self.register(game_class)
    @game_classes ||= []
    @game_classes << game_class
    @game_classes.uniq!
  end
  
  def self.collect_from_specific_game(type)
    specific_games = @game_classes.find {|game_class| game_class.to_rails_s == type}
    yield(specific_games)
  end

end
module GameTheory
  module BaseGame
    def self.included(base)
      Games.register(base)
      base.extend(ClassMethods)  
      base.has_many :cards, :as => :game
      base.has_many :game_scores, :as => :game
      base.has_many :game_results, :as => :game
      base.belongs_to :user
      base.validates_presence_of :name, :description, :color
      base.validates_inclusion_of :color, :in => ["red", "green", "yellow"]
      base.validates_numericality_of :weight, :only_integer => true, :greater_than => 0
      base.named_scope :removed, :conditions => {:removed => true}
      base.named_scope :not_removed, :conditions => {:removed => false}
    end
  
    module ClassMethods
      def path
        "/#{to_plural_sym}/"
      end
      
      def to_sym
        to_rails_s.to_sym
      end
      
      def to_plural_sym
        to_rails_s.pluralize.to_sym
      end
      
      def to_rails_s
        to_s.underscore
      end
    end

    def path
      self.class.path
    end

    def cards_with_uniq_users(cards)
      cards_for_user = Hash.new
      cards.each do |card|
        cards_for_user[card.user] ||= []
        cards_for_user[card.user] << card
      end
      cards_for_user.each_value.collect do |user_cards|
        user_cards[0]
      end   
    end 

    def played_cards
      self.cards.find_all { |card| card.played? && card.payoff.nil? }
    end    
  end
end