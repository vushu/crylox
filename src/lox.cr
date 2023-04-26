require "./token_type"

module Lox
  had_error = false

  def self.report(line : Int32, where : String, message : String)
    print("[line #{line}] Error #{where} : #{message}")
    had_error = true
  end

  def self.error(token : Token, message : String)
    if token.type == Token
      report(token.line, " at end", message)
    else
      report(token.line, " at '#{token.lexeme}'", message)
    end
  end
end
