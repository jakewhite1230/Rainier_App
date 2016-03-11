class UsersController < ApplicationController
	skip_before_action :authenticate_tenant!, :only => [ :index ]
 
  def dashboard
  	if current_user
  		if session[:tenant_id]
  			Tenant.set_current_tenant session[:tenant_id]
  		else
  			Tenant.set_current_tenant current_user.tenants.first
  		end
  		@tenant = Tenant.current_tenant
  		params[:tenant_id] = @tenant.id
    end
end
end
