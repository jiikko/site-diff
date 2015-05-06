class CompositedScreenshotsController < ApplicationController
  def index
    @from_captured_version = CapturedVersion.find(params[:from_version_id])
    @site = @from_captured_version.site
    @composited_screenshots = CompositedScreenshot.where(
      before_captured_version_id: params[:from_version_id],
      after_captured_version_id: params[:from_version_id].to_i + 1
    )

    @captured_environment_with_names = CapturedEnvironment.
      includes(captured_page: :target_page).
      joins(captured_page: :captured_version).
      where(captured_versions: { id: @from_captured_version }).group_by { |x| x.name }
  end

  def show
    @composited_screenshot = CompositedScreenshot.find(params[:id])
  end
end
