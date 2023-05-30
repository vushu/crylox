require "./token"

module Crylox
  getter :tokens

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
      @tokens.push Token.new(TokenType::Eof, "", nil, @line)
    end

    private def scan_token : Void
      c = advance
      case c
      when '('
        add_token(TokenType::Left_paren)
      when ')'
        add_token(TokenType::Right_paren)
      when '{'
        add_token(TokenType::Left_brace)
      when '}'
        add_token(TokenType::Right_brace)
      when ','
        add_token(TokenType::Comma)
      when '.'
        add_token(TokenType::Dot)
      when '-'
        add_token(TokenType::Minus)
      when '+'
        add_token(TokenType::Plus)
      when ';'
        add_token(TokenType::Semicolon)
      when '*'
        add_token(TokenType::Star)
      when '!'
        add_token(match('=') ? TokenType::Bang_equal : TokenType::Bang)
      when '='
        add_token(match('=') ? TokenType::Equal_equal : TokenType::Equal)
      when '<'
        add_token(match('=') ? TokenType::Less_equal : TokenType::Less)
      when '>'
        add_token(match('=') ? TokenType::Greater_equal : TokenType::Greater)
      when '/'
        if match('/')
          while peek != '\n' && !at_end?
            advance
          end
        else
          add_token(TokenType::Slash)
        end
      when ' ', '\r', '\t'
      when '\n'
        @line += 1
      when '"'
      else
        if digit?(c)
          handle_number
        elsif alphanumeric?(c)
          handle_identifier
        else
          puts "#{@line} Unexpected character"
        end
      end
    end

    private def handle_identifier
      while alphanumeric?(peek)
        advance
      end
      text = @source[@start...@current]
      type = KEYWORDS.fetch(text) { TokenType::Identifier }
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
      add_token(TokenType::Number, @source[@start...@current].to_f32)
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

    private def add_token(type : TokenType, literal : LiteralType)
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
