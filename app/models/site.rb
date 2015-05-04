class Site < ActiveRecord::Base
  has_many :target_pages
  has_many :captured_versions
  has_one :captured_version, ->{ order(name: :desc).limit(1) }

  def create_captured_version_with_inc!
    last_captured_version = captured_versions.last || captured_versions.create
    captured_versions.create(name: last_captured_version.name + 1)
  end
end
