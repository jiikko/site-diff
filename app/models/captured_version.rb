class CapturedVersion < ActiveRecord::Base
  belongs_to :site

  # eagerしてexistS?したいので
  has_one :composited_screenshot, foreign_key: :before_captured_version_id

  has_many :captured_pages
  has_many :captured_environments, through: :captured_pages # unuse

  has_many :before_composited_screenshots, foreign_key: :before_captured_version_id, class: CompositedScreenshot
end
