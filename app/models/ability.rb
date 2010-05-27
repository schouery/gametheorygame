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
      end# researcher
    else
      can :manage, Card
    end
  end
end