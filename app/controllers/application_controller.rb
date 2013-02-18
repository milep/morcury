class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  helper_method :current_site
  helper_method :is_editing?
  
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def current_site
    @current_site ||= Site.find_for_request(request)
  end

  def is_editing?
    cookies[:editing] == 'true' && user_signed_in?
  end  
end
