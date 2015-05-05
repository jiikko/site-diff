class Site < ActiveRecord::Base
  has_many :target_pages
  has_many :captured_versions
  has_one :captured_version, ->{ order(name: :desc).limit(1) }

  accepts_nested_attributes_for :target_pages, allow_destroy: true

  def create_captured_version_with_inc!
    name = captured_versions.last.try!(:name) || 0
    captured_versions.create(name: name + 1)
  end
end
