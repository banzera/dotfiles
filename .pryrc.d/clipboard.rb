begin
  require 'clipboard'

  def cbcopy(value)
    Clipboard.copy value unless value.empty?
    flash_message = value.empty? ? "Sorry, nothing to copy" : "Copied to clipboard"
    output.print "# #{flash_message}: ".green
    output.puts %Q("#{value}")
  end

  Pry.commands.block_command("cp", "Copy last result to the Clipboard", :listing => "cp") do |line|
    cbcopy(pry_instance.last_result.to_s)
  end

  Pry.commands.block_command("cpa", "Copy last result to the Clipboard, in awesome format", :listing => "cp") do |line|
    cbcopy(pry_instance.last_result.ai(plain: true))
  end

  Pry.commands.block_command("cpe", "Copy last exception details to the Clipboard", :listing => "cpe") do |line|
    value = pry_instance.last_exception
    cbcopy(value.nil? ? "" : value.inspect)
  end

rescue LoadError
  handle_load_error 'clipboard'
end
