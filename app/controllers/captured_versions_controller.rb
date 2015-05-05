class CapturedVersionsController < ApplicationController
  def show
    @site = Site.find(params[:site_id])
    @captured_version = CapturedVersion.find(params[:id])
    @captured_environment_with_names = CapturedEnvironment.
      includes(captured_page: :target_page).
      joins(captured_page: :captured_version).
      where(captured_versions: { id: @captured_version }).group_by { |x| x.name }
  end
end
