class CapturedVersion < ActiveRecord::Base
  belongs_to :site

  # eagerしてexistS?したいので
  has_one :composited_screenshot, foreign_key: :before_captured_version_id

  has_many :captured_pages
  has_many :captured_environments, through: :captured_pages # unuse
  # need chain 'where' to after_captured_environment_id
  has_many :composited_screenshots, through: :captured_environments # unuse
end
