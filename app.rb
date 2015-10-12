require 'sinatra/base'
require 'sass'
require 'haml'
require 'coffee-script'

require './app/models'

module AssignPart
  # Routing Controller
  class App < Sinatra::Base
    set :views, settings.root + '/app/views'

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
      @members = @concert.members
      case params[:mode]
      when 'inst'
        haml :inst_by_title
      else # includes 'member'
        haml :part_by_member
      end
    end

    helpers do
      def instruments_included_in(titles)
        titles.map(&:instruments).flatten.map(&:name).uniq
      end

      def append_part_name_to_inst(parts_and_insts)
        parts_and_insts.map do |pi|
          if pi.class == Part
            pi.name
          else # Instrument
            pi.name_with_instrument
          end
        end
      end
    end
  end
end
