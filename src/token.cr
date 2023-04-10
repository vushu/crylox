require "./token_type"

module Crylox
  alias Literal = String | Float32 | Nil

  class Token
    getter type

    def initialize(@type : TokenType, @lexeme : String, @literal : Literal, @line : Int32)
    end

    def to_string
      "#{@type} #{@lexeme} #{@literal}"
    end
  end
end
