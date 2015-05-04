class CapturedPage < ActiveRecord::Base
  belongs_to :captured_version
  belongs_to :target_page

  has_attached_file :screenshot, styles: { normal: "600x600>", thumb: "200x200>" }
  validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
