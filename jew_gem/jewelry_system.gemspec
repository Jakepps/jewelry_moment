# frozen_string_literal: true

require_relative "lib/jewerly_system/version"

Gem::Specification.new do |spec|
  spec.name = "jewerly_system"
  spec.version = JewerlySystem::VERSION
  spec.authors = ["Jake Epps"]
  spec.email = ["nullexp.team@gmail.com"]
  spec.summary = "Jewerly App"
  spec.description = "А gem that allows you to get pass for patterns"
  spec.homepage = "https://github.com/Jakepps/Ruby_Moment"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.add_dependency 'mysql2'
  spec.files = Dir.glob("**/*")
end
