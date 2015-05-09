require "sugoi_webpage_capture"

namespace :db do
  # こういうふうに使う => $ bundle exec rake db:capture SITES=google,gigazine
  desc "capture"
  task capture: :environment do
    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      site.create_captured_version_with_inc!
      puts "current version is #{site.captured_version.name}."
      site.target_pages.each do |target_page|
        unless target_page.browser_cookie
          target_page.create_browser_cookie # TODO remove
        end

        if ENV["DEBUG"]
          puts "start #{target_page.fullpath}"
        end
        captured_page = site.captured_version.captured_pages.create!(
          target_page: target_page
        )
        Parallel.each(CapturedEnvironment::ENVIRONMENTS) do |environment_name|
        # CapturedEnvironment::ENVIRONMENTS.each do |environment_name|
          browser = SugoiWebpageCapture::Browser.new(environment_name)
          if ENV["DEBUG"]
            puts "  #{environment_name}"
          end
          captured_page.captured_environments.create!(
            name: environment_name,
            screenshot: browser.capture(target_page.fullpath) { |x|
              target_page.browser_cookie.set(x)
              sleep(2) if environment_name == :chrome
            }.tempfile
          )
          browser.quit
        end
      end
    end
  end
end
