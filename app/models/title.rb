# vim:set fileencoding=utf-8:

class Title < ActiveRecord::Base
  belongs_to :concert
  has_many :parts, -> { includes :instruments }

  def instruments
    parts.map(&:instruments).flatten
  end

  def instruments_assigned_to(member)
    instruments.select { |i| i.members.include? member }
  end

  def parts_assigned_to(member)
    insts = instruments_assigned_to(member)
    parts = insts.map(&:part).uniq.select { |part| (part.instruments - insts).empty? }
    insts - parts.map(&:instruments).flatten + parts
  end

  def members_playing(instrument)
    instruments.select { |i| i.name == instrument }
      .map { |i| i.members.map(&:name) }.uniq
  end
end
