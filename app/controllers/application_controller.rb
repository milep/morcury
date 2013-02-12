class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  helper_method :current_site
  
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def current_site
    Site.find_for_request(request)
  end

end
