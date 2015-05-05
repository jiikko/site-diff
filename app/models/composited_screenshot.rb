class CompositedScreenshot < ActiveRecord::Base
  belongs_to :captured_environment_a, foreign_key: :captured_environment_a_id, class: CapturedEnvironment
  belongs_to :captured_environment_b, foreign_key: :captured_environment_b_id, class: CapturedEnvironment

  has_attached_file :compared_image, styles: { normal: "", top: "" },
    all: "-quality 19 -strip -resize 70%"
  validates_attachment_content_type :compared_image, :content_type => /\Aimage\/.*\Z/

  def self.crete_compared_image(captured_environment_a, captured_environment_b)
    tempfile = Tempfile.new(["c", "png"])
    averaged_pixel = `composite -compose difference #{captured_environment_a.screenshot.path} #{captured_environment_b.screenshot.path} #{tempfile.path}`.to_i
    create!(
      captured_environment_a: captured_environment_a,
      captured_environment_b: captured_environment_b,
      averaged_pixel:         averaged_pixel,
      compared_image:         File.open(tempfile.path)
    )
  end
end
