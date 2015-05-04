require 'capybara/dsl'
require "selenium-webdriver"

namespace :db do
  # こういうふうに使う => $ bundle exec rake db:capture SITES=google,gigazine
  desc "capture"
  task capture: :environment do
    include Capybara::DSL # gemにするべきか

    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      site.create_captured_version_with_inc!

      # setup
      Capybara.run_server = false
      Capybara.configure do |config|
        config.run_server = false
        config.default_driver = :selenium
      end
      Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome)
      end

      site.target_pages.each do |target_page|
        visit site.url + target_page.path
        tempfile = Tempfile.new("ss")
        page.driver.save_screenshot(tempfile, full: true)
        site.captured_version.captured_pages.create!(
          screenshot:  tempfile,
          target_page: target_page
        )
        tempfile.unlink
      end
    end
  end
end
