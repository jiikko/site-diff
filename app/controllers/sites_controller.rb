class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def show
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to sites_path, notice: 'created'
    else
      render :new
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      redirect_to sites_path, notice: 'updated'
    else
      render :edit
    end
  end

  private

  def site_params
    params.require(:site).permit!
  end
end
