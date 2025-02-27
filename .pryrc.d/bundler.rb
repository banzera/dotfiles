# Add all gems in the global gemset to the $LOAD_PATH so they can be used even
# in places like 'rails console'.
if defined?(::Bundler)
  puts "Configuring LOAD_PATH to include gems in the @global gemset..."
  @global = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  $LOAD_PATH.concat(Dir.glob("#{@global}/gems/*/lib")) if @global
end

def handle_load_error(file)
  puts "Missing library `#{file}`. Try `rvm @global do gem install #{file}`".red
end
