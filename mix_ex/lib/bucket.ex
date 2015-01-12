defmodule MixEx.Bucket do
	@doc """
	Starts a new bucket
	"""
	def start_link do
		Agent.start_link(fn -> HashDict.new end)
	end

	@doc """
	Gets a value from the `bucket` by `key`
	"""
	def get(bucket, key) do
		Agent.get(bucket, &HashDict.get(&1, key))
	end

	@doc """
	Puts the `value` for the given `key` in the `bucket`
	"""
	def put(bucket, key, value) do
		Agent.update(bucket, &HashDict.put(&1, key, value))
	end

	@doc """
	Deletes `key` from `bucket`
	"""
	def delete(bucket, key) do
		Agent.get_and_update(bucket, &HashDict.pop(&1, key))
	end

	defmodule Supervisor do
		use Elixir.Supervisor

		def start_link(opts \\ []) do
			Elixir.Supervisor.start_link(__MODULE__, :ok, opts)
		end

		def start_bucket(supervisor) do
			Elixir.Supervisor.start_child(supervisor, [])
		end

		def init(:ok) do
			children = [
				worker(MixEx.Bucket, [], restart: :temporary)
			]

			supervise(children, strategy: :simple_one_for_one)
		end
	end

end