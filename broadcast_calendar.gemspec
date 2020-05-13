# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/broadcast_calendar/version'

Gem::Specification.new do |s|
  s.name = 'art19-broadcast_calendar'
  s.version = BroadcastCalendar::VERSION
  s.authors = ['Mike Subelsky']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.email = 'mike@subelsky.com'
  s.extra_rdoc_files = %w[README.md]
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/subelsky/broadcast_calendar'
  s.metadata = { 'github_repo' => 'ssh://github.com/art19/broadcast_calendar' }
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.summary = 'Returns the beginning and ending Gregorian (civil) dates for months or weeks in the broadcast calendar.'
  s.description = 'Library tht returns the beginning and ending Gregorian (civil) dates for months or weeks in the broadcast calendar.'
  s.test_files = `git ls-files spec`.split("\n")
  s.add_development_dependency 'rake',          '~> 13.0.1'
  s.add_development_dependency 'rspec',         '>= 3.9.0'
  s.add_development_dependency 'rubocop',       '~> 0.79.0'
  s.add_development_dependency 'rubocop-rspec', '~> 1.35.0'

  s.license = 'MIT'
end
