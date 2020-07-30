require_relative "./denver_zoo_cli/version"
require_relative "./denver_zoo_cli/cli"

require 'open-uri'
require 'nokogiri'
require 'pry'

module DenverZooCli
  class Error < StandardError; end
  # Your code goes here...
end
