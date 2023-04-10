require "./spec_helper"

include Crylox
describe Crylox do
  describe "#scan_tokens, should get token BANG_EQUAL" do
    it "should scan tokens" do
      scanner = Scanner.new("!=")
      tokens = scanner.scan_tokens
      tokens.each do |tok|
        print "#{tok.to_string}\n"
      end
      tokens.first.type.should eq(TokenType::BANG_EQUAL)
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
end
