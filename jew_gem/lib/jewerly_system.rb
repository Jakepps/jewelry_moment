# frozen_string_literal: true

require_relative "jewerly_system/version"

module JewerlySystem
  Dir[File.dirname(__FILE__) + '/source/**/*.rb'].each { |file|
    puts file
    require file
  }
end
