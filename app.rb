require 'sinatra/base'
require 'sass'
require 'haml'
require 'coffee-script'
require 'sinatra/activerecord'

class Band < ActiveRecord::Base
  has_many :concerts
  has_and_belongs_to_many :members
end
class Concert < ActiveRecord::Base
  belongs_to :band
  has_many :titles, -> { includes :parts }
end
class Title < ActiveRecord::Base
  belongs_to :concert
  has_many :parts, -> { includes :instruments }
end
class Part < ActiveRecord::Base
  belongs_to :title
  has_many :instruments, -> { includes :members }
end
class Instrument < ActiveRecord::Base
  belongs_to :part
  has_and_belongs_to_many :members
end
class Member < ActiveRecord::Base
  has_and_belongs_to_many :bands
  has_and_belongs_to_many :instruments
end

module AssignPart
  class App < Sinatra::Base
    get '/' do
      @bands = Band.all
      haml :band_list
    end

    get '/stylesheets/base.css' do
      scss :'scss/base'
    end

    get '/:band' do
      @band = Band.find_by_path params[:band]
      @concerts = @band.concerts
      haml :concert_list
    end

    get '/:band/:concert' do
      @band = Band.find_by_path params[:band]
      @concert = @band.concerts.find_by_path params[:concert]
      @titles = @concert.titles
      @members = @band.members
      case params[:mode]
      when 'inst'
        haml :inst_by_title
      else # includes 'member'
        haml :part_by_member
      end
    end

    helpers do
      def part_by_member(title, member)
        insts = title.parts
                .map(&:instruments)
                .flatten
                .select { |i| i.members.include? member }
        insts.map(&:part).uniq.each do |part|
          if (part.instruments - insts).empty?
            insts = insts - part.instruments + [part]
          end
        end
        insts.map(&:name).join('<br />')
      end

      def instruments(titles)
        titles.map do |t|
          t.parts.map do |p|
            p.instruments.map(&:name)
          end
        end.flatten.uniq
      end

      def inst_by_title(title, inst)
        insts = title.parts.map { |p| p.instruments.select { |i| i.name == inst } }.flatten
        insts.map { |i| i.members.map(&:name) }.uniq.join('<br />')
      end
    end
  end
end
