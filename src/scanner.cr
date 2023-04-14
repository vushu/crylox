require "./token"

module Crylox
  class Scanner
    def initialize(@source : String)
      @tokens = Array(Token).new
      @start = 0
      @current = 0
      @line = 0
    end

    def scan_tokens
      while !at_end?
        @start = @current
        scan_token
      end
      @tokens.push Token.new(TokenType::EOF, "", nil, @line)
    end

    private def scan_token
      c = advance
      case c
      when '('
        add_token(TokenType::LEFT_PAREN)
      when ')'
        add_token(TokenType::RIGHT_PAREN)
      when '{'
        add_token(TokenType::LEFT_BRACE)
      when '}'
        add_token(TokenType::RIGHT_BRACE)
      when ','
        add_token(TokenType::COMMA)
      when '.'
        add_token(TokenType::DOT)
      when '-'
        add_token(TokenType::MINUS)
      when '+'
        add_token(TokenType::PLUS)
      when ';'
        add_token(TokenType::SEMICOLON)
      when '*'
        add_token(TokenType::STAR)
      when '!'
        add_token(match('=') ? TokenType::BANG_EQUAL : TokenType::BANG)
      when '='
        add_token(match('=') ? TokenType::EQUAL_EQUAL : TokenType::EQUAL)
      when '<'
        add_token(match('=') ? TokenType::LESS_EQUAL : TokenType::LESS)
      when '>'
        add_token(match('=') ? TokenType::GREATER_EQUAL : TokenType::GREATER)
      when '/'
        if match('/')
          while peek != '\n' && !at_end?
            advance
          end
        else
          add_token(TokenType::SLASH)
        end
      when ' ', '\r', '\t'
      when '\n'
        @line += 1
      when '"'
      else
        if digit?(c)
          handle_number
        else
          if alphanumeric?(c)
            handle_identifier
          else
            puts "#{@line} Unexpected character"
          end
        end
      end
    end

    private def handle_identifier
      while alphanumeric?(peek)
        advance
      end
      text = @source[@start..@current]
      type = KEYWORDS.fetch(text) { TokenType::IDENTIFIER }
      add_token(type)
    end

    private def handle_number
      while digit?(peek)
        advance
      end
      if peek == '.' && digit?(peek_next)
        advance # Consume the "."
        while digit?(peek)
          advance
        end
      end
      add_token(TokenType::NUMBER, @source[@start..@current])
    end

    private def match(expected : Char) : Bool
      return false if at_end?
      return false unless expected == @source[@current]
      @current += 1
      true
    end

    private def add_token(type : TokenType)
      add_token(type, nil)
    end

    private def add_token(type : TokenType, literal : Literal)
      text = @source[@start..@current]
      @tokens.push(Token.new(type, text, literal, @line))
    end

    private def at_end?
      @current >= @source.size
    end

    private def advance
      c = @source[@current]
      @current += 1
      c
    end

    private def peek : Char
      return '\0' if at_end?
      @source[@current]
    end

    private def peek_next : Char
      return '\0' if @current + 1 > @source.size
      @source[@current + 1]
    end
  end

  private def digit?(c : Char) : Bool
    c >= '0' && c <= '9'
  end

  private def alpha?(c : Char) : Bool
    (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_'
  end

  private def alphanumeric?(c : Char) : Bool
    digit?(c) || alpha?(c)
  end
end
