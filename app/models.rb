# vim:set fileencoding=utf-8:

require 'sinatra/activerecord'
Dir.glob(File.dirname(__FILE__) + '/models/*') do |f|
  require f
end
