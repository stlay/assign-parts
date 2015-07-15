# vim:set fileencoding=utf-8:

class Instrument < ActiveRecord::Base
  belongs_to :part
  has_and_belongs_to_many :members
end
