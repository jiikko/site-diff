class Site < ActiveRecord::Base
  has_many :target_pages
  has_many :captured_versions
  has_one  :captured_version, ->{ order(name: :desc) }

  accepts_nested_attributes_for :target_pages, allow_destroy: true

  def inc_captured_version!
    name = captured_versions.last.try!(:name) || 0
    captured_versions.create(name: name + 1)
  end
end
