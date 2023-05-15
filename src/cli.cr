require "./scanner"
require "./expr"
require "./ast_printer"
require "./parser"
require "./interpreter"
module Crylox::CLI
  def self.run_file(path : String)
    return puts "file doesn't exists" unless File.exists?(path)
    puts "file exists!"
    File.open(path) do |file|
      file.gets_to_end
    end
  end

  def self.run(source : String)
  end

  def self.run_prompt
    while (line = read_line) != nil
      break if line == "q"
    end
  end

  def self.run_program
    if ARGV.size > 1
      print("Usage Crylox [script]")
      exit(64)
    elsif ARGV.size == 1
      print "running lox file\n"
      print run_file(ARGV[0])
    else
      run_prompt
    end
  end
end
