require "./token_type"

module Crylox
  alias LiteralType = String | Float32 | Nil

  class Token
    getter type
    getter lexeme
    getter literal

    def initialize(@type : TokenType, @lexeme : String, @literal : LiteralType, @line : Int32)
    end

    def to_string
      "#{@type} #{@lexeme} #{@literal}"
    end
  end
end
