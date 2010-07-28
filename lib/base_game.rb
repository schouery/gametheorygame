#This class works as a iterator for all game classes
class Games
  #Loads all models on /app/models folder (except for Ability.rb which is not
  #a ActiveRecord subclass)
  def self.load_models
    if !@models_loaded
      Dir.glob(RAILS_ROOT+'/app/models/*.rb').each {|file| require file unless file =~ /ability/}
      @models_loaded = true
    end
  end
  #Execute block to each specific game class
  def self.each_specific_game
    load_models
    @game_classes.each do |game_class|
      yield(game_class)
    end
  end

  #Execute block to each specific game class and sum them up in one array
  def self.collect_results
    load_models
    @game_classes.inject([]) do |sum, game_class|
      sum += yield(game_class)
    end
  end

  #Execute a block to a specific game class according to type, which should be
  #equal to some class to_rails_s method
  def self.collect_from_specific_game(type)
    load_models
    specific_games = @game_classes.find {|game_class| game_class.to_rails_s == type}
    yield(specific_games)
  end

  #Registers game_class as a game class
  def self.register(game_class)
    @game_classes ||= []
    @game_classes << game_class
    @game_classes.uniq!
  end
end

#Namespace for the system
module GameTheory
  #This module should be included by all game classes
  module BaseGame
    #Executed when included, it defines some validations and associations for
    #the game class. Note that the table should have the columns
    #user_id(integer), name (string), description(string), color(string),
    #weight(integer) and removed(boolean) or the model should define this
    #acessors and provide another solution to the persistency
    def self.included(base)
      Games.register(base)
      base.extend(ClassMethods)  
      base.has_many :cards, :as => :game, :dependent => :destroy
      base.has_many :game_scores, :as => :game, :dependent => :destroy
      base.has_many :game_results, :as => :game, :dependent => :destroy
      base.belongs_to :user
      base.validates_presence_of :name, :description, :color
      base.validates_inclusion_of :color, :in => ["red", "green", "yellow"]
      base.validates_numericality_of :weight, :only_integer => true, :greater_than => 0
      base.named_scope :removed, :conditions => {:removed => true}
      base.named_scope :not_removed, :conditions => {:removed => false}
    end

    #This methods will become class methods of the game class
    module ClassMethods
      #Class rails name, that is, with underscore
      def to_rails_s
        to_s.underscore
      end
      #Class rails name to a symbol
      def to_sym
        to_rails_s.to_sym
      end
      #Class rails name with plural to a symbol
      def to_plural_sym
        to_rails_s.pluralize.to_sym
      end
      #Path for the view of this game
      def path
        "/#{to_plural_sym}/"
      end
    end
    #Path for the view of this game class
    def path
      self.class.path
    end
    #Return an array of cards which don't repeat users
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
    #Return cards that has been playd but don't have payoff
    def played_cards
      self.cards.find_all { |card| card.played? && card.payoff.nil? }
    end    
  end
end