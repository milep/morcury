class Admin::ImagesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @site = Site.find params[:site_id]
    @images = @site.images
  end

  def create
    site = Site.find params[:site_id]
    image = site.images.build params[:image]
    image.save!
    redirect_to admin_site_images_path(site)
  end
end
