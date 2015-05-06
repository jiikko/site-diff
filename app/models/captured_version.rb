class CapturedVersion < ActiveRecord::Base
  belongs_to :site

  has_one :composited_screenshot, foreign_key: :before_captured_version_id  # eager 用

  has_many :captured_pages
end
