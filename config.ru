$:.unshift(File.dirname(__FILE__) + '/lib')
require './app'

run Haptic::Web.new
