namespace :db do
  # こういうふうに使う => $ bundle exec rake db:compare SITES=google,gigazine
  desc "最近からふたつのバージョンを比較する"
  task compare: :environment do
    ENV['SITES'].split(/,/).each do |site_name|
      site = Site.find_by!(name: site_name)
      version_before, version_after = site.captured_versions.last(2) # a is later, b is last
      puts "compare version to #{version_before.name}, #{version_after.name}"
      captured_pages_before = version_before.captured_pages.group_by { |x| x.target_page.path }
      captured_pages_after = version_after.captured_pages.group_by { |x| x.target_page.path }
      captured_pages_before.each do |before_key, before_value|
        puts "start #{before_key}"
        captured_page_before = before_value.first
        # target_page-captured_page の図. 1つしか要素がないのでfirst
        captured_pages_after[before_key].first.captured_environments
        captured_pages_after[before_key].first.captured_environments.each do |environment_after|
          puts "  #{environment_after.name}"
          environment_before = captured_page_before.captured_environments.detect { |x| x.name == environment_after.name }
          unless environment_before
            puts '[INFO] 前後の画像が欠けているのでSkipする'
            next
          end
          CompositedScreenshot.crete_compared_image(
            version_before,
            version_after,
            environment_before,
            environment_after
          )
        end
      end
    end
  end
end
