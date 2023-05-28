class Interpreter
  def evaluate(expr : Literal)
    if (expr.is_a?(Float32))
      print("number ","\n")
      expr.value.as(Float32)
    else
      print(" typeof ", typeof(expr.value))
    end
    print(" ", expr.value,"\n")
    expr.value
  end

  def evaluate(expr : Binary)
    print("Binary evaluation\n")
    left = evaluate(expr.left)
    right = evaluate(expr.right)
    if (left.nil?)
      print("wtf nil")
    end

    case expr.operator.type
    when TokenType::MINUS
      return left.as(Float32) - right.as(Float32)
    when TokenType::SLASH
      return left.as(Float32) / right.as(Float32)
    when TokenType::STAR
      return left.as(Float32) * right.as(Float32)
    when TokenType::PLUS
      if left.is_a?(Number) && right.is_a?(Number)
        return left.as(Float32) + right.as(Float32)
      elsif left.is_a?(String) && right.is_a?(String)
        return left.to_s + right.to_s
      end
      raise "Should not end here"
    when TokenType::GREATER
      return left.as(Float32) > right.as(Float32)
    when TokenType::GREATER_EQUAL
      return left.as(Float32) >= right.as(Float32)
    when TokenType::BANG_EQUAL
      return left.as(Float32) != right.as(Float32)
    when TokenType::EQUAL_EQUAL
      return left.as(Float32) == right.as(Float32)
    else
      puts "no case"
    end
    puts "We shouldn't reach NIL?"
    nil
  end

  def evaluate(expr : Grouping)
    evaluate(expr.expression)
  end

  def evaluate(expr : Unary)
    right = evaluate(expr.right)
    case expr.operator.type
    when TokenType::BANG
      return !truthy?(right)
    when TokenType::MINUS
      puts(right.to_s)
      check_number_operand(expr.operator, right)
      return -(right.as(Float32))
    else
    end
    nil
  end

  private def check_number_operand(operator : Token, operand)
    if operand.is_a?(Float32)
      return
    end
    raise "Operand must be a number"
  end

  def evaluate(expr : Expr)
    evaluate(expr)
  end

  private def truthy?(object) : Bool
    return false if object.nil?
    if object.is_a?(Bool)
      return object.as(Bool)
    end
    true
  end
end
