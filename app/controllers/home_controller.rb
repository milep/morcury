class HomeController < ApplicationController
  layout :layout_with_mercury
  helper_method :is_editing?
  
  def index
  end

  private
  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end
  
  def is_editing?
    cookies[:editing] == 'true' && user_signed_in?
  end  
end
