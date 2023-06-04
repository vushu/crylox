require "./spec_helper"

include Crylox

describe Crylox do
  describe "Should generate stmt" do
    it "should create Print stmt" do
      tok = Token.new(TokenType::Star, "*", nil, 1)
      literal = Literal.new("3.14")
      literal2 = Literal.new("333")
      binary = Binary.new(literal, tok, literal2)

      print_statemenet : Print = Print.new(binary)

      ast_printer = ASTPrinter.new
      ast_printer.print(print_statemenet).should eq("(* 3.14 333)")
    end
  end
end
