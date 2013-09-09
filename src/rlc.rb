#!/usr/bin/ruby

require './lambda'

include Lambda::AST

# Some sample ASTs
one = Fun.new(:s, Fun.new(:z,
		App.new( Var.new(:s), Var.new(:z) )
	) )

inc = Fun.new(:n,
		Fun.new(:s, Fun.new(:z,
			App.new(
				Var.new(:s),
				App.new( App.new( Var.new(:n), Var.new(:s) ), Var.new(:z) )
			)
		) )
	)

add = Fun.new(:a, Fun.new(:b,
		App.new( App.new( Var.new(:b), inc), Var.new(:a) )
	) )

require './display/lambda'

p one
p inc
p add

puts '-'*80

with = Fun.new(:z, Var.new(:z) )

# Test substituting a single variable.
p test = Var.new(:x)
p test.swap(:x, with)    # matching   (should be replaced)
p test.swap(:y, with)    # unmatching (should be left alone)
puts

# Test substituting in a compound expression: application.
p test = App.new( Var.new(:x), Var.new(:y) )
p test.swap(:x, with)    # matching   (should be replaced)
p test.swap(:y, with)    # matching   (should be replaced)
p test.swap(:w, with)    # unmatching (should be left alone)
puts

# Test substituting a variable in a subexpression of a function.
p test = Fun.new(:x, Var.new(:y) )
p test.swap(:x, with)    # bound (should be protected in the whole subexpression)
p test.swap(:y, with)    # free  (can be replaced, but watch out for captures)
p test.swap(:y, Fun.new(:z, Var.new(:x) ) )    # Capturing demonstration.
puts

# Test substituting a variable in a subexpression of a function, more compound.
p test = Fun.new(:x, App.new( Var.new(:x), Var.new(:y) ) )
p test.swap(:x, with)    # bound (should be protected in the whole subexpression)
p test.swap(:y, with)    # free  (can be replaced, but watch out for captures)
p test.swap(:y, Fun.new(:z, Var.new(:x) ) )    # Capturing demonstration.
puts

# Complicated substitution example.
p test = App.new(
	Fun.new(:x, App.new( Var.new(:x), Var.new(:x) ) ),
	App.new( Var.new(:x), Fun.new(:x, App.new( Var.new(:x), Var.new(:y) ) ) )
)
p test.swap(:x, with)
p test.swap(:y, with)

puts '-'*80
# Function application.
puts App.new(inc,one)
p inc.applyTo(one)