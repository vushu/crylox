require "./spec_helper"

include Crylox

describe Crylox do
  describe "Should print correctly" do
    it "Should print binary expr" do
      literal = Literal.new("3.14")
      literal2 = Literal.new("333")

      tok = Token.new(TokenType::Star, "*", nil, 1)
      binary = Binary.new(literal, tok, literal2)

      printer = AstPrinter.new
      printer.print(binary).should eq("(* 3.14 333)")
    end
    it "Should print Binary expr as expected" do
      minus_tok = Token.new(TokenType::Minus, "-", nil, 1)
      star_tok = Token.new(TokenType::Star, "*", nil, 1)
      unary = Unary.new(minus_tok, Literal.new("123"))
      grouping = Grouping.new(Literal.new(45.67))
      binary = Binary.new(unary, star_tok, grouping)

      printer = AstPrinter.new
      printer.print(binary).should eq("(* (- 123) (group 45.67))")
    end
  end
end
