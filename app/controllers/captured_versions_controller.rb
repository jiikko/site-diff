class CapturedVersionsController < ApplicationController
  def show
    @site = Site.find(params[:site_id])
    @captured_version = CapturedVersion.find(params[:id])
  end
end
