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
      when "admin"
        can :create, User
        can :manage, User, id: user.id
      when "customer"
        cannot :create, User
        cannot :read, User
      else
        cannot :create, User
        cannot :read, User
      end
    end
  end
end
