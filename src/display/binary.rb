# Display code for Lambda Calculus expressions' elements.
# Binary lambda encoding.

module Lambda::AST
	
	# Reference to a variable.
	class Var
		def to_s
			# FIXME: Use the actual binary codes.
			binaryName = name.to_s
			"1{#{binaryName}}0"
		end
	end
	
	# Anonymous function definition.
	class Fun
		def to_s
			"00#{subexpr}"
		end
	end
	
	# Function application.
	class App
		def to_s
			"01#{code}#{data}"
		end
	end
	
end