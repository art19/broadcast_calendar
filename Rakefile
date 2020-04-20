# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'bundler'

Bundler.require
Bundler::GemHelper.install_tasks

desc 'Build the package and publish it to rubygems.pkg.github.com'
task publish: :build do
  require 'broadcast_calendar'

  raise 'Set environment variable GEM_PUSH_KEY to the name of a key in ~/.gem/credentials' unless ENV['GEM_PUSH_KEY']

  system("gem push --key #{ENV['GEM_PUSH_KEY']} --host https://rubygems.pkg.github.com/art19 " \
         "pkg/broadcast_calendar-#{BroadcastCalendar::VERSION}.gem")
end

task default: :spec

desc 'run specs'
RSpec::Core::RakeTask.new
