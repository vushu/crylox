require "./token"

module Crylox
  abstract class Expr
  end

  macro generate_expr(name_of_class, construction_args)
    class {{name_of_class}} < Expr
      # Adding property
      {% for arg, expr_type in construction_args %}
        property :{{arg}}
      {% end %}

      # Creating initialize
      def initialize(
        {% for arg, expr_type in construction_args %}
          @{{arg}} : {{expr_type}},
        {% end %})

      end

      def construction_args
        {{ construction_args }}
      end

      def name_of_class
        {{ name_of_class.stringify }}
      end

    end
  end

  # auto generating expressions
  generate_expr(Binary, {left: Expr, operator: Token, right: Expr})
  generate_expr(Grouping, {expression: Expr})
  generate_expr(Literal, {value: LiteralType})
  generate_expr(Unary, {operator: Token, right: Expr})
end
