# Display code for Lambda Calculus expressions' elements.
# Pure lambda style.

module Lambda::AST
	
	# Common code for all lambda expressions.
	module Expr
		# Enclose the expression in parentheses if its nesting level is
		# lower than the current level of the outer scope.
		def enclose(outerLevel)
			level < outerLevel  ?  '(' + to_s + ')'  :  to_s
		end
	end
	
	# Reference to a variable.
	class Var
		def to_s
			name.to_s
		end
	end
	
	# Anonymous function definition.
	class Fun
		def to_s
			"L#{param}.#{subexpr.enclose(level)}"
		end
	end
	
	# Function application.
	class App
		def to_s
			"#{code.enclose(level)} #{data.enclose(level+1)}"
		end
	end
	
end