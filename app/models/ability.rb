class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? 'admin'
      can :manage, :all
    end
    if user.has_role? 'editor'
      can :manage, Page do |page|
        user.sites.include? page.site
      end
      # can :manage, :all
    end
  end
end
