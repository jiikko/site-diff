require "sugoi_webpage_capture"

namespace :db do
  # こういうふうに使う => $ bundle exec rake db:capture SITES=google,gigazine
  desc "capture"
  task capture: :environment do
    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      site.create_captured_version_with_inc!
      puts "starting version is #{site.captured_version.name}."
      # CapturedEnvironment::ENVIRONMENTS.each do |environment_name|
      Parallel.each(CapturedEnvironment::ENVIRONMENTS, in_processes: 4) do |environment_name|
        browser = SugoiWebpageCapture::Browser.new(environment_name)
        site.target_pages.each { |target_page|
          if ENV["DEBUG"]
            print "."
          end

          unless target_page.browser_cookie
            target_page.create_browser_cookie # TODO remove
          end
          captured_page = site.captured_version.captured_pages.find_or_create_by(
            target_page: target_page
          )
          CapturedEnvironment.create!(
            name: environment_name,
            captured_page: captured_page,
            screenshot: browser.capture(target_page.fullpath) { |x|
              target_page.browser_cookie.set(x)
              sleep(2) if environment_name == :chrome
            }.tempfile
          )
        }
        browser.quit
      end

      puts
    end
  end
end
