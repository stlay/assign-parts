# vim:set fileencoding=utf-8:

class Concert < ActiveRecord::Base
  belongs_to :band
  has_and_belongs_to_many :members
  has_many :titles, -> { includes :parts }
end
