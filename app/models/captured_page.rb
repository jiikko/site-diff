class CapturedPage < ActiveRecord::Base
  belongs_to :captured_version
  belongs_to :target_page

  has_attached_file :screenshot, styles: { thumb: "100x100>" }
  validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
