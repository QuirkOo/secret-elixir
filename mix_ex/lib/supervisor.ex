defmodule MixEx.Supervisor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	@manager_name MixEx.EventManager
	@registry_name MixEx.Registry
	@bucket_sup_name MixEx.Bucket.Supervisor

	def init(:ok) do
		children = [
			worker(GenEvent, [[name: @manager_name]]),
			supervisor(MixEx.Bucket.Supervisor, [[name: @bucket_sup_name]])
			worker(MixEx.Registry, [@manager_name, @bucket_sup_name, [name: @registry_name]])
		]

		supervise(children, strategy: :one_for_one)
	end
end