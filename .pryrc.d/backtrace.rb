Pry::Commands.block_command "callerf", "Filter the caller backtrace" do
  output = caller.reject! { |line| line["byebug"] || line["pry"] } 
  # puts "\e[31m#{output.join("\n")}\e[0m"
  puts output.join("\n")
end
