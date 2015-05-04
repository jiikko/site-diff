class Site < ActiveRecord::Base
  has_many :target_pages
  has_many :captured_versions
end
