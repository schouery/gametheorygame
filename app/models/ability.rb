class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.researcher?
      can :read, :all
      can :create, SymmetricFunctionGame
      can :create, TwoPlayerMatrixGame
      can :statistics, SymmetricFunctionGame
      can :statistics, TwoPlayerMatrixGame
      can :create, Invitation
      can :remove_researcher, User do |researcher|
        researcher == user
      end
      can :remove, SymmetricFunctionGame do |game|
        game.user == user
      end      
      can :remove, TwoPlayerMatrixGame do |game|
        game.user == user
      end      
      can :manage, :card do |card|
        card.user == user
      end
    else
      can :read, Card do |card|
        #card.user == user  card can be nil
        true
      end
      can :update, Card do |card|
        card.user == user
      end
      can :destroy, Card do |card|
        card.game.color != "red" && card.user == user
      end            
    end
  end
end