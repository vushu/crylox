require "./token"
require "./lox"

module Crylox
  class Parser
    def initialize(@tokens : Array(Token))
      @current = 0
    end

    def parse : Expr | Nil
      begin
        return expression
      rescue exception
        return nil
      end
    end

    private def check?(type : TokenType) : Bool
      return false if at_end?
      peek.type == type
    end

    private def advance : Token
      unless at_end?
        @current += 1
      end
      previous
    end

    private def previous : Token
      @tokens[@current - 1]
    end

    private def peek : Token
      @tokens[@current]
    end

    private def at_end? : Bool
      peek == TokenType::EOF
    end

    private def synchronize : Void
      advance
      while !at_end?
        return if previous.type == TokenType::Semicolon
        case peek.type
        when TokenType::Class, TokenType::Fun,
             TokenType::Var, TokenType::If,
             TokenType::While, TokenType::Print,
             TokenType::Return
          # Doing nothing
        else
        end
        advance
      end
    end

    private def equality
      expr = comparison
      while match(TokenType::BangEqual, TokenType::EqualEqual)
        operator = previous
        right = comparison
        expr = Binary.new(expr, operator, right)
      end
      expr
    end

    private def comparison
      expr = term
      while match(TokenType::Greater, TokenType::GreaterEqual)
        operator = previous
        right = term
        expr = Binary.new(expr, operator, right)
      end
      expr
    end

    private def term
      expr = factor
      while match(TokenType::Minus, TokenType::Plus)
        operator = previous
        right = factor
        expr = Binary.new(expr, operator, right)
      end
      expr
    end

    private def factor
      expr = unary
      while match(TokenType::Slash, TokenType::Star)
        operator = previous
        right = unary
        expr = Binary.new(expr, operator, right)
      end
      expr
    end

    private def unary
      if match(TokenType::Bang, TokenType::Minus)
        operator = previous
        right = unary
        return Unary.new(operator, right)
      end
      primary
    end

    private def primary : Expr
      return Literal.new(false) if match(TokenType::False)
      return Literal.new(true) if match(TokenType::True)
      return Literal.new(nil) if match(TokenType::Nil)
      return Literal.new(previous.literal) if match(TokenType::Number, TokenType::String)
      if match(TokenType::LeftParen)
        expr = expression
        consume(TokenType::RightParen, "Expect ')' after expression.")
        return Grouping.new(expr)
      end
      raise error(peek, "Expression expected")
    end

    private def expression
      equality
    end

    private def consume(type : TokenType, message : String) : Token
      return advance if check?(type)
      raise error(peek, message)
    end

    private def match(*types : TokenType)
      types.each do |type|
        if check?(type)
          advance
          return true
        end
      end
      false
    end

    private def peek : Token
      @tokens[@current]
    end

    private def previous : Token
      @tokens[@current - 1]
    end

    private def error(token : Token, message : String) : ParseError
      Lox.error(token, message)
      ParseError.new
    end
  end

  class ParseError < Exception
  end
end
