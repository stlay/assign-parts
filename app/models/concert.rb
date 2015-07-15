# vim:set fileencoding=utf-8:

class Concert < ActiveRecord::Base
  belongs_to :band
  has_many :titles, -> { includes :parts }
end
