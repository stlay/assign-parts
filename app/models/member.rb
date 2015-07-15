# vim:set fileencoding=utf-8:

class Member < ActiveRecord::Base
  has_and_belongs_to_many :bands
  has_and_belongs_to_many :instruments
end
