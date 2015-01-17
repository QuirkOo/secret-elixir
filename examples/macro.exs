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