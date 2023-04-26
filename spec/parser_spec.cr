require "./spec_helper"

include Crylox
describe Crylox do
  describe "Parsing a stream of tokens" do
    it "should parse tokens" do
      source_code = "40 + 2 == 4 * 10 + 2";
      scanner = Scanner.new(source_code)
      tokens = scanner.scan_tokens
      parser = Parser.new(tokens)
      expr = parser.parse
      printer = AstPrinter.new
      if (expr)
        printer.print(expr).should eq("(==  (+  40  2 ) (+  (*  4  10 ) 2))")
      end
    end
  end
end
