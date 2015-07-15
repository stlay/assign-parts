# vim:set fileencoding=utf-8:

class Band < ActiveRecord::Base
  has_many :concerts
  has_and_belongs_to_many :members
end
