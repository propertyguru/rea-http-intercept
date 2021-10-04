require 'bundler/gem_tasks'
require 'geminabox-client'

task publish: :build do
  puts "\n#{'-' * 38} copying gem to rea-rubygems #{'-' * 38}\n\n"

  spec_path = Dir['*.gemspec'].first
  gemspec = Bundler.load_gemspec spec_path

  gem_filename = "pkg/#{gemspec.name}-#{gemspec.version}.gem"
  Geminabox::Client.new('http://rubygems.delivery.realestate.com.au/').upload(gem_filename)
end
