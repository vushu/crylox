require "./spec_helper"

include Crylox

class DummyExpr < Expr
end

describe Crylox do
  describe "Should instantiate correctly" do
    it "Binary should be as expected" do
      tok = Token.new(TokenType::EOF, "", nil, 1)
      binary = Binary.new(DummyExpr.new, tok, DummyExpr.new)
      binary.construction_args.should eq({left: Crylox::Expr, operator: Crylox::Token, right: Crylox::Expr})
    end
    it "Literal should be as expected" do
      literal = Literal.new(nil)
      literal.construction_args.should eq({value: LiteralType})
    end
  end
end
