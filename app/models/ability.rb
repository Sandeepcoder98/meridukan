class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user  
    if user.has_role? :admin
      can :manage, :all
    end
    if user.has_role? :seller
        debugger 
      can :read, :all
      can :create, :all
    end
    if user.has_role? :buyer
      can :read, :all
      cannot :create ,:all
    end
  end
end
