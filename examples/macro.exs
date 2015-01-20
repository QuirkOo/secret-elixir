defmodule Unless do
	def fun(clause, expression) do
		if(!clause, do: expression)
	end

	defmacro macro(clause, expression) do
		quote do
			if(!unquote(clause), do: unquote(expression))
		end
	end
end

require Unless

Unless.fun true do
	IO.puts "This should never be printed"
end

Unless.macro true do
	IO.puts "This should never be printed"
end