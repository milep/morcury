class Admin::SnippetsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  load_resource :site
  load_and_authorize_resource :through => [:site, :snippet_container]
  
  def index
  end

  def new
  end

  def create
    respond_to do |format|
      if @snippet.save
        format.html { redirect_to admin_site_snippets_path(@site), notice: 'Snippet was successfully created.' }
        format.json { render json: @snippet, status: :created, location: @snippet }
      else
        format.html { render action: "new" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to admin_site_snippets_path(@site), notice: 'Snippet was successfully updated.' }
        format.json { render json: @snippet, status: :created, location: @snippet }
      else
        format.html { render action: "edit" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end
end
