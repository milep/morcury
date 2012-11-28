class PagesController < ApplicationController
  layout :layout_with_mercury
  helper_method :is_editing?

  def show
    params[:slug] ||= '/'
    @page = Page.where("slug" => params[:slug]).first
    raise Mongoid::Errors::DocumentNotFound.new(Page, "slug" => params[:slug]) unless @page
    
    render template: "pages/#{@page.template || 'show'}"
  end

  def mercury_update
    params[:slug] ||= '/'
    page = Page.where("slug" => params[:slug]).first
    raise Mongoid::Errors::DocumentNotFound.new(Page, "slug" => params[:slug]) unless page

    page.update_content(params[:content])
    page.save!
    render text: ""
  end
  
  private
  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end
  
  def is_editing?
    cookies[:editing] == 'true' && user_signed_in?
  end  
end
