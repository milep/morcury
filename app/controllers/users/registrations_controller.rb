class Users::RegistrationsController < Devise::RegistrationsController
  layout 'admin'
  
  def new
    flash[:notice] = 'Registrations are disabled'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'Registrations are disabled'
    redirect_to root_path
  end
end
