class CompositedScreenshot < ActiveRecord::Base
  belongs_to :captured_environment_before, foreign_key: :captured_environment_before_id, class: CapturedEnvironment
  belongs_to :captured_environment_after,  foreign_key: :captured_environment_after_id, class: CapturedEnvironment

  has_attached_file :compared_image, styles: { normal: "", top: "" },
    all: "-quality 19 -strip -resize 70%"
  validates_attachment_content_type :compared_image, :content_type => /\Aimage\/.*\Z/

  def self.crete_compared_image(captured_environment_a, captured_environment_b)
    tempfile = Tempfile.new(["c", "png"])
    averaged_pixel = `composite -compose difference #{captured_environment_a.screenshot.path} #{captured_environment_b.screenshot.path} #{tempfile.path}`.to_i
    attrs = {
      captured_environment_before: captured_environment_a,
      captured_environment_after: captured_environment_b
    }
    composited_screenshot = find_by(attrs)
    attrs.merge!(
      averaged_pixel: averaged_pixel,
      compared_image: File.open(tempfile.path)
    )
    if composited_screenshot
      composited_screenshot.update(attrs)
    else
      create!(attrs)
    end
  end
end
