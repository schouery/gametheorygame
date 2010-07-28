#This class define the permissions for the whole system
class Ability
  #It uses the CanCan gem
  include CanCan::Ability

  #Sets the permissions
  def initialize(user)
    if user.admin? || (user.researcher? &&
          Configuration[:full_permissions_to_researchers])
      can :manage, :all
    elsif user.researcher?
      researcher_abilities(user)
    else
      user_abilities(user)
    end
  end

  private

  #Adds games permissions, they are equal to every game class
  def manage_games(user)
    Games.each_specific_game do |game_class|
      can :create, game_class
      can :statistics, game_class
      can :remove, game_class do |game|
        game.user == user
      end 
    end
  end

  #Permissions for Researchers
  def researcher_abilities(user)   
    can :read, :all  
    manage_games(user)
    can :invite_researcher, User if Configuration[:researcher_can_invite_researcher]
    can :researcher_manual, nil
    can :remove_researcher, User do |researcher|
      researcher == user
    end
    user_abilities(user)
  end

  #Permissions for Users
  def user_abilities(user)
    can :read, Item do |item|
      item.user == user
    end
    can :use, Item do |item|
      item.user == user
    end
    can :create_auction, Item do |item|
      item.user == user
    end
    can :read, Card
    can :update, Card do |card| 
      card.user == user && !card.played?
    end
    can :delete, Card do |card|
      card.game.color != "red" && card.user == user
    end
  end
end