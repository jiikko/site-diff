class CapturedEnvironment < ActiveRecord::Base
  ENVIRONMENTS = %i(
    chrome
    firefox
    iphone5
    iphone6
  )

  belongs_to :captured_page

  has_attached_file :screenshot, styles: { normal: "600x600>", thumb: "200x200>" }
  validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
