# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      cannot :create, User
      cannot :read, User
    else
      case user.role
      when "super_admin"
        can :create, User
        can :manage, [User]
        can :manage, Order
        can :manage, Service
      when "admin"
        can :create, User
        can :manage, User, id: user.id
        can :manage, Order
        can :manage, Service
      when "customer"
        cannot :create, User
        can :read, User, id: user.id
        can :read, Order
        can :read, Service
      else
        cannot :create, User
        cannot :read, User
        can :read, Order
        can :read, Service
      end
    end
  end
end
