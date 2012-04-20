class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Employee.new       
    case user.department_id      
      when 1                                                              # Management
        can :manage, :all
      when 2
				can :manage, [Client, Proposal, Invoice]                                   # Sales
        can [:read,:edit], Employee, :employees => {:id => user.id}
      when 3
        can :manage, [Assignment, MaterialAssignment, LaborAssignment]    # Labor
    end
  end

end
