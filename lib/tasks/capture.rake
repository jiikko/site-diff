require "sugoi_webpage_capture"

namespace :db do
  # こういうふうに使う => $ bundle exec rake db:capture SITES=google,gigazine
  desc "capture"
  task capture: :environment do
    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      site.create_captured_version_with_inc!
      screenshot = SugoiWebpageCapture::Browser.new
      site.target_pages.each do |target_page|
        tempfile = screenshot.capture(site.url + target_page.path)
        site.captured_version.captured_pages.create!(
          screenshot:  tempfile,
          target_page: target_page
        )
        tempfile.unlink
      end
    end
  end
end
