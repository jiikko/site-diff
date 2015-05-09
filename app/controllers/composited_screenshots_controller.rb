class CompositedScreenshotsController < ApplicationController
  def index
    @from_captured_version = CapturedVersion.find(params[:from_version_id])
    @site = @from_captured_version.site
    @composited_screenshots_with_path = CompositedScreenshot.where(
      before_captured_version_id: params[:from_version_id],
      after_captured_version_id:  params[:to_version_id]
    ).includes(before_captured_environment: :captured_page).
    order("captured_environments.name").
    group_by { |x| x.before_captured_environment.captured_page.target_page }
  end

  def show
    @composited_screenshot = CompositedScreenshot.find(params[:id])
  end
end
