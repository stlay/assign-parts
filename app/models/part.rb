# vim:set fileencoding=utf-8:

class Part < ActiveRecord::Base
  belongs_to :title
  has_many :instruments, -> { includes :members }
end
