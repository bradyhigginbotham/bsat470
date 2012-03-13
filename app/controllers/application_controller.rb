class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to "/admin"
  end

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end

  def authenticate_admin_user!
    if employee_signed_in? && !current_employee.admin?
			flash[:notice] = current_employee.role + "s do not have access to this area. " #{link}.html_safe
			redirect_to root_path and return
		end
    authenticate_employee!
  end

  def current_admin_user
    return nil if employee_signed_in? && !current_employee.admin?
    current_employee
  end

end
