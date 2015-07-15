# vim:set fileencoding=utf-8:

class Instrument < ActiveRecord::Base
  belongs_to :part
  has_and_belongs_to_many :members

  def name_with_instrument
    (part.name.include? name) ? name : "#{name} (#{part.name})"
  end
end
