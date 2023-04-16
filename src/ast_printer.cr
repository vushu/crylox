require "./expr"

module Crylox
  # Since crystal supports multiple dispatch
  # we don't need to make visitor pattern,
  # Instead just make prints for each Expr type
  class AstPrinter
    def print(expr : Binary) : String
      parenthesize(expr.operator.lexeme, [expr.left, expr.right])
    end

    def print(expr : Grouping) : String
      parenthesize("group", [expr.expression])
    end

    def print(expr : Literal) : String
      return "nil" if expr.value.nil?
      expr.value.to_s
    end

    def print(expr : Unary)
      parenthesize(expr.operator.lexeme, [expr.right])
    end

    def print(expr : Expr)
      self.print(expr)
    end

    def parenthesize(name : String, exprs : Array(Expr))
      builder = String::Builder.new
      builder << "(#{name}"
      exprs.each do |expr|
        builder << " "
        builder << self.print(expr)
      end
      builder << ")"
      builder.to_s
    end
  end
end
