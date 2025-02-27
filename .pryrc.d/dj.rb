Pry.commands.block_command("rlj", "Run most recent delayed job", :listing => "rlj") do |line|
  Delayed::Worker.new.run Delayed::Job.last
end
