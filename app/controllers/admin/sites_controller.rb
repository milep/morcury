class Admin::SitesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  end

  def show
  end

  def new
  end

  def create
    respond_to do |format|
      if @site.save
        format.html { redirect_to admin_sites_path, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
end
