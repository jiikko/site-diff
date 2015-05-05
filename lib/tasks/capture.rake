require "sugoi_webpage_capture"

namespace :db do
  # こういうふうに使う => $ bundle exec rake db:capture SITES=google,gigazine
  desc "capture"
  task capture: :environment do
    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      site.create_captured_version_with_inc!
      site.target_pages.each do |target_page|
        captured_page = site.captured_version.captured_pages.create!(
          target_page: target_page
        )
        CapturedEnvironment::ENVIRONMENTS.each do |environment_name|
          puts "start #{environment_name} to #{captured_page.url}"
          screenshot = SugoiWebpageCapture::Browser.new(environment_name)
          tempfile = screenshot.capture(site.url + target_page.path)
          captured_page.captured_environments.create!(
            name: environment_name,
            screenshot:  tempfile
          )
          tempfile.unlink
        end
      end
    end
  end
end
