class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to :back
  end

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end

  def authenticate_admin_user!
    if account_signed_in? && !current_account.admin?
			#link = "<a href=\"#{url_for(destroy_account_session_path)}\">Try again</a>"
			flash[:notice] = current_account.role + "s do not have access to this area. " #{link}.html_safe
			redirect_to root_path and return
		end
    authenticate_account!
  end

  def current_admin_user
    return nil if account_signed_in? && !current_account.admin?
    current_account
  end

end
