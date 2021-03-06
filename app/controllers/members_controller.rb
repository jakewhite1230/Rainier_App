class MembersController < ApplicationController

  # uncomment to ensure common layout for forms
  # layout  "sign", :only => [:new, :edit, :create]
@tenant = Tenant.current_tenant
  def new()
    @member = Member.new()
    @user   = User.new()
    @tenant = Tenant.current_tenant
  end
  def create()
    @user = User.new( user_params )
    @tenant = Tenant.current_tenant

    # ok to create user, member
    if @user.save_and_invite_member() && @user.create_member( member_params )
      flash[:notice] = "New member added and invitation email sent to #{@user.email}."
      redirect_to  users_dashboard_path
    else
      flash[:error] = "errors occurred!"
      @member = Member.new( member_params ) # only used if need to revisit form
      render :new
    end
  end


  private

  def member_params()
    params.require(:member).permit(:first_name, :last_name)
  end

  def user_params()
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
