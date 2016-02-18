class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user  
    if user.has_role? :admin
      can :manage, :all
    end
    if user.has_role? :seller
      can :manage, Product
    end
    if user.has_role? :buyer
    end
  end
end
