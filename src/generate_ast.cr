require "./token"

module Crylox
  abstract class Expr
  end

  abstract class Stmt
  end

  macro generate_ast_node(base_class, name_of_class, construction_args)
    class {{name_of_class}} < {{base_class}}
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

      def base_class
        {{ base_class }}
      end

      def construction_args
        {{ construction_args }}
      end

      def name_of_class
        {{ name_of_class.stringify }}
      end

    end
  end

  # generate expressions
  generate_ast_node(Expr, Binary, {left: Expr, operator: Token, right: Expr})
  generate_ast_node(Expr, Grouping, {expression: Expr})
  generate_ast_node(Expr, Literal, {value: LiteralType})
  generate_ast_node(Expr, Unary, {operator: Token, right: Expr})

  # generate statements
  generate_ast_node(Stmt, Expression, {expression: Expr})
  generate_ast_node(Stmt, Print, {expression: Expr})
end
