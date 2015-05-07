class TargetPage < ActiveRecord::Base
  belongs_to :site

  has_one :browser_cokkie

  def fullpath
    "#{site.url}#{path}"
  end
end
