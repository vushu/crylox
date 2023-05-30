module Crylox
  KEYWORDS =
    {
      and:    TokenType::And,
      class:  TokenType::Class,
      else:   TokenType::Else,
      false:  TokenType::False,
      for:    TokenType::For,
      fun:    TokenType::Fun,
      if:     TokenType::If,
      nil:    TokenType::Nil,
      or:     TokenType::Or,
      print:  TokenType::Print,
      return: TokenType::Return,
      super:  TokenType::Super,
      this:   TokenType::This,
      true:   TokenType::True,
      var:    TokenType::Var,
      while:  TokenType::While,
    }
  enum TokenType
    # Single-character tokens.
    Left_paren
    Right_paren
    Left_brace
    Right_brace
    Comma
    Dot
    Minus
    Plus
    Semicolon
    Slash
    Star

    # One or two character tokens.
    Bang
    Bang_equal
    Equal
    Equal_equal
    Greater
    Greater_equal
    Less
    Less_equal

    # Literals.
    Identifier
    String
    Number

    # Keywords.
    And
    Class
    Else
    False
    Fun
    For
    If
    Nil
    Or
    Print
    Return
    Super
    This
    True
    Var
    While

    Eof
  end
end
