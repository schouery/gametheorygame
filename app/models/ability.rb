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
      can :manage, :card
    else
      can :read, Card
      can :update, Card
      can :destroy, Card do |card|
        card.game.color != "red"
      end            
    end
  end
end