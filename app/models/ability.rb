class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Account.new       
    case user.role      
      when "Admin"
        can :manage, :all
			when "Supervisor"
				can :manage, [Client, Employee, Proposal, WorkOrder]
				cannot :manage, Account
      when "Manager"
				can :manage, [Employee, WorkOrder]
				cannot :manage, [Client, Proposal]
      end
  end

end
