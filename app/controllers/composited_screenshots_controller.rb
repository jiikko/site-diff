class CompositedScreenshotsController < ApplicationController
  def index
    @composited_screenshots = CompositedScreenshot.where(before_captured_version_id: params[:from_version])
  end
  def show
    @composited_screenshot = CompositedScreenshot.find(params[:id])
  end
end
