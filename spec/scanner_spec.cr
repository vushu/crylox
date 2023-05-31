require "./spec_helper"

include Crylox
describe Crylox do
  describe "#scan_tokens, should get token BANG_EQUAL" do
    it "should scan tokens" do
      scanner = Scanner.new("!=")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::BangEqual)
      tokens.last.type.should eq(TokenType::EOF)
    end
  end

  describe "#scan_tokens, should not tokenize SLASH when using // (comment)" do
    it "should scan tokens" do
      scanner = Scanner.new("// just a comment")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::EOF)
    end
  end

  describe "should ignore whitespace", tags: "whitespace" do
    it "should scan tokens" do
      scanner = Scanner.new(" \t\r")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::EOF)
    end
  end

  describe "should resolve as number", tags: "number" do
    it "should scan tokens" do
      scanner = Scanner.new("233.3")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::Number)
      tokens.last.type.should eq(TokenType::EOF)
    end
  end

  describe "should resolve as mama identifier", tags: "identifier" do
    it "should scan tokens" do
      scanner = Scanner.new("mama")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::Identifier)
      tokens.last.type.should eq(TokenType::EOF)
    end
  end

  describe "should resolve as papa identifier", tags: "identifier" do
    it "should scan tokens" do
      scanner = Scanner.new("papa")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::Identifier)
      tokens.last.type.should eq(TokenType::EOF)
    end
  end

  describe "should resolve as super as keyword SUPER", tags: "keyword" do
    it "should scan tokens" do
      scanner = Scanner.new("super")
      tokens = scanner.scan_tokens
      tokens.first.type.should eq(TokenType::Super)
      tokens.last.type.should eq(TokenType::EOF)
    end
  end
end
