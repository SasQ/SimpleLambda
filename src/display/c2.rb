# Display code for Lambda Calculus expressions' elements.
# Pure lambda style.

module Lambda::AST
	
	# Common code for all lambda expressions.
	module Expr
		def inspect
			to_s + ';'
		end
		
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
			"#{param} -> #{subexpr.enclose(level)}"
		end
	end
	
	# Function application.
	class App
		def to_s
			# Account for left-associativity of application by faking the level up on the right side.
			"#{code.enclose(level)} #{data.enclose(level+1)}"
		end
	end
	
end