# Lambda Calculus expressions' elements.
module Lambda module AST
	
	# Common code for all lambda expressions.
	module Expr
		def inspect
			to_s
		end
	end
	
	# Reference to a variable.
	class Var < Struct.new(:name)
		include Expr
		
		def level
			3
		end
		
		# Substitute variable to something else.
		# Used in alpha substitution and beta reduction.
		# A variable is replaced as a whole.
		def swap(what,to)
			name == what ? to : self
		end
	end
	
	# Anonymous function definition.
	class Fun < Struct.new(:param, :subexpr)
		include Expr
		
		def level
			1
		end
		
		# Substitute variable to something else.
		# Used in alpha substitution and beta reduction.
		# In a function we substitute variables only in its subordinate expression (body).
		# TODO: Watch out for capturing variables!
		def swap(what,to)
			if param == what        # If the variable to substitute is bound in the current lambda expression,
				self                # it's a different variable local to this lambda and we cannot substitute it.
			else
				Fun.new( param, subexpr.swap(what,to) )    # But we can substitute a free variable
			end                                            # in the controlled subexpression.
		end
		
		def applyTo(what)
			puts "let  #{param} = #{what}  in  #{subexpr}"
			subexpr.swap(param,what)
		end
	end
	
	# Function application.
	class App < Struct.new(:code, :data)
		include Expr
		
		def level
			2
		end
		
		# Substitute variable to something else.
		# Used in alpha substitution and beta reduction.
		# In function application, we can substitute in both subexpressions.
		def swap(what,to)
			App.new( code.swap(what,to), data.swap(what,to) )
		end
	end
	
end end # module Lambda::AST