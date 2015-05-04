class CapturedVersion < ActiveRecord::Base
  belongs_to :site

  has_many :captured_pages
end
