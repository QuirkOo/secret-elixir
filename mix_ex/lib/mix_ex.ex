defmodule MixEx do
	use Application

	def start(_type, _args) do
		MixEx.Supervisor.start_link
	end
end
