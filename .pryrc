require_relative '.pryrc.d/bundler'
# require_relative '.pryrc.d/backtrace'
require_relative '.pryrc.d/byebug'
require_relative '.pryrc.d/awesome'
require_relative '.pryrc.d/dj'
require_relative '.pryrc.d/paperclip'
require_relative '.pryrc.d/factory_bot'
require_relative '.pryrc.d/clipboard'
require_relative '.pryrc.d/pretty_sql'
require_relative '.pryrc.d/nori'

wd = `pwd`.to_s

segments = wd.split '/'
pj = segments.last.strip

fname = "~/.pry_history_#{pj}"

puts "Running pry from #{wd}"
puts "using history file: #{fname}"

Pry.config.history_file = fname

require 'binding_of_caller'

module Kernel
  (ENV['ALIAS_FOR_BINDING_PRY'] || 'bp').split(',').each do |m|
    define_method(m) do
      Pry.start(binding.of_caller(1))
    end
  end
end
