class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin? || (user.researcher? && Configuration[:full_permissions_to_researchers])
      can :manage, :all
    elsif user.researcher?
      researcher_abilities(user)
    else
      user_abilities(user)
    end
  end

 private  
 
  def manage_games
    games = [SymmetricFunctionGame, TwoPlayerMatrixGame]
    games.each do |game|
      can :create, game
      can :statistics, game
      can :remove, game
    end
  end
  
  def researcher_abilities(user)
    manage_games
    can :read, :all
    can :create, Invitation 
    can :remove_researcher, User do |researcher|
      researcher == user
    end
    can :invite_researcher, User if Configuration[:researcher_can_invite_researcher]
    can :manage, :card do |card|
      card.user == user
    end
  end

  def user_abilities(user)
    can :user, Item do |item|
      item.user == user
    end
    can :read, Item do |item|
      item.user == user
    end
    can :create_auction, Item do |item|
      item.user == user
    end
    can :read, Card
    can :update, Card do |card| 
      card.user == user
    end
    can :destroy, Card do |card|
      card.game.color != "red" && card.user == user
    end
  end
end