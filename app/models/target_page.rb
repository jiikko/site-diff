class TargetPage < ActiveRecord::Base
  belongs_to :site

  def fullpath
    "#{site.url}#{path}"
  end
end
