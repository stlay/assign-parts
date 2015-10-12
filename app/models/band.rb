# vim:set fileencoding=utf-8:

class Band < ActiveRecord::Base
  has_many :concerts
end
