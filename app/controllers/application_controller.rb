class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_tenant!
@tenant = Tenant.current_tenant
  
     ##    milia defines a default max_tenants, invalid_tenant exception handling
     ##    but you can override these if you wish to handle directly
  rescue_from ::Milia::Control::MaxTenantExceeded, :with => :max_tenants
  rescue_from ::Milia::Control::InvalidTenantAccess, :with => :invalid_tenant

  protected

  def after_sign_in_path_for(resource)
    users_dashboard_path
  end
  def after_sign_out_path_for(resource)
    root_path
  end

end
