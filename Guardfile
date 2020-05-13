# frozen_string_literal: true

guard 'spork', rspec_port: 9500 do
  watch(%r{^spec/spec_helper.rb$})
end

guard 'rspec', version: 2 do
  watch(%r{spec/(.*)_spec.rb})
  watch(%r{lib/(.*)\.rb})                            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                       { 'spec' }
end
