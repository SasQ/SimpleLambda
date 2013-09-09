# Display code for Lambda Calculus expressions' elements.
# Ruby Procs style.

module Lambda::AST
	
	# Reference to a variable.
	class Var
		def to_s
			name.to_s
		end
	end
	
	# Anonymous function definition.
	class Fun
		def to_s
			"->#{param} {#{subexpr}}"
		end
	end
	
	# Function application.
	class App
		def to_s
			"#{code}[#{data}]"
		end
	end
	
end