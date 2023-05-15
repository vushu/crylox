require "./spec_helper"

include Crylox
describe Crylox do
  describe "Interpret Source Code" do
    it "should interpret" do
      source_code = "(2 + 2) * -10"
      scanner = Scanner.new(source_code)
      tokens = scanner.scan_tokens
      parser = Parser.new(tokens)
      expr = parser.parse
      interpreter = Interpreter.new
      if expr
        print("Evaluated : ", interpreter.evaluate(expr))
      end
    end
  end
end
