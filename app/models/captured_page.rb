class CapturedPage < ActiveRecord::Base
  belongs_to :captured_version
  belongs_to :target_page

  has_many :captured_environments
end
