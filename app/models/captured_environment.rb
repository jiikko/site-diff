class CapturedEnvironment < ActiveRecord::Base
  ENVIRONMENTS = %i(
    chrome
    firefox
    iphone5
    iphone6
  )

  belongs_to :captured_page

  has_attached_file :screenshot, styles: { normal: "", top: "" },
    convert_options: {
      top: "-crop 1024x720+0+0",
      all: "-quality 19 -strip -resize 70%",
  }
  validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
