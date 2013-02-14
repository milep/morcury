class PagesController < ApplicationController
  layout :layout_with_mercury
  before_filter :authenticate_user!, except: [:show]

  def show
    params[:slug] = '/' if params[:slug].blank?
    @page = current_site.pages.find_or_initialize_by(slug: params[:slug]).tap do |page|
      if page.new_record?
        page.update_content('page_title' => {'value' => 'No content'},
                            'page_content' => {'value' => 'This page doesn\'t have content yet.'})
      end
    end

    render template: "pages/#{@page.template || 'default'}"
  end

  def index
    @site = current_site

    render '/mercury/pages', layout: false
  end

  def create
    page = current_site.pages.create(params[:page])
    
    redirect_to "/#{I18n.locale}/#{page.slug}"
  end

  def destroy
    page = current_site.pages.find(params[:id])
    page.destroy
    redirect_to root_path
  end

  def mercury_update
    params[:slug] = '/' if params[:slug].blank?
    page = current_site.pages.find_or_initialize_by(slug: params[:slug])
    authorize! :update, page
    
    page.update_content(params[:content])
    page.save!

    cookies['editing'] = false
    render text: ""
  end

  def properties
    @site = current_site
    path_params = Rails.application.routes.recognize_path params[:path]
    path_params[:slug] = '/' if path_params[:slug].blank?
    @page = current_site.pages.find_or_initialize_by(slug: path_params[:slug])
    @options = []
    @options << ['default', 'default']
    @options << ['jumbotron and 2 columns', 'jumbotron_2cols']
    @options << ['jumbotron, 3 boxes, 2 columns', 'jumbotron_3boxes_2cols']
    render '/mercury/properties', layout: false
  end

  def update_properties
    params[:slug] = '/' if params[:slug].blank?
    page = current_site.pages.find_or_initialize_by(slug: params[:slug])
    authorize! :update, page
    page.template = params[:template]
    page.styles['page_jumbotron_style'] = params[:page_jumbotron_style]
    page.save!
    slug = page.slug == '/' ? '' : page.slug
    redirect_to "/#{I18n.locale}/#{slug}"
  end

  def move_down
    page = current_site.pages.find(params[:id])
    page.move_down!
    slug = page.slug == '/' ? '' : page.slug
    redirect_to "/#{I18n.locale}/#{slug}"
  end

  def move_up
    page = current_site.pages.find(params[:id])
    page.move_up!
    slug = page.slug == '/' ? '' : page.slug
    redirect_to "/#{I18n.locale}/#{slug}"
  end
  
  private
  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end
end
