class CompositedScreenshot < ActiveRecord::Base
  belongs_to :before_captured_version,     class: CapturedVersion
  belongs_to :after_captured_version,      class: CapturedVersion
  belongs_to :before_captured_environment, class: CapturedEnvironment
  belongs_to :after_captured_environment,  class: CapturedEnvironment

  has_attached_file :compared_image, styles: { normal: "", top: "" },
    convert_options: {
      top: "-crop 1024x720+0+0",
      all: "-quality 19 -strip -resize 70%"
  }
  validates_attachment_content_type :compared_image, :content_type => /\Aimage\/.*\Z/

  def self.crete_compared_image(before_version, after_version, captured_environment_a, captured_environment_b)
    tempfile = Tempfile.new(["c", "png"])
    averaged_pixel = `composite -compose difference #{captured_environment_a.screenshot.path} #{captured_environment_b.screenshot.path} #{tempfile.path}`.to_i
    attrs = {
      before_captured_version:     before_version,
      after_captured_version:      after_version,
      before_captured_environment: captured_environment_a,
      after_captured_environment:  captured_environment_b
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
