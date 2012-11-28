class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    Rails.logger.debug "set locale: #{params[:locale]}"
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end
