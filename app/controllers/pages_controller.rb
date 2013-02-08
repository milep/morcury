class PagesController < ApplicationController
  layout :layout_with_mercury
  helper_method :is_editing?
  before_filter :authenticate_user!, only: [:mercury_update]

  def show
    params[:slug] ||= '/'
    @page = current_site.pages.find_or_initialize_by(slug: params[:slug]).tap do |page|
      if page.new_record?
        page.update_content('page_title' => {'value' => 'No content'},
                            'page_content' => {'value' => 'This page doesn\'t have content yet.'})
      end
    end
    Rails.logger.debug "TEMPLATE: #{@page.template}"
    render template: "pages/#{@page.template || 'show'}"
  end

  def mercury_update
    params[:slug] ||= '/'
    page = current_site.pages.find_or_initialize_by(slug: params[:slug])
    authorize! :update, page
    
    page.update_content(params[:content])
    page.save!

    cookies['editing'] = false
    render text: ""
  end

  def properties
    path_params = Rails.application.routes.recognize_path params[:path]
    @page = current_site.pages.find_or_initialize_by(slug: path_params[:slug])
    @options = []
    @options << ['default', 'show']
    @options << ['jumbotron and 2 columns', 'jumbotron_2cols']
    render :properties, layout: false
  end

  def update_properties
    page = current_site.pages.find_or_initialize_by(slug: params[:slug])
    authorize! :update, page
    page.template = params[:template]
    page.save!
    redirect_to "/#{I18n.locale}/#{page.slug}"
  end
  
  private
  def current_site
    site = Site.find_for_request(request)
  end

  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end
  
  def is_editing?
    cookies[:editing] == 'true' && user_signed_in?
  end  
end
