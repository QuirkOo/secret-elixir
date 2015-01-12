defmodule MixEx.RegistryTest do
	use ExUnit.Case, async: true

	defmodule Forwarder do
		use GenEvent

		def handle_event(event, parent) do
			send parent, event
			{:ok, parent}
		end
	end

	setup do
		{:ok, manager} = GenEvent.start_link
		{:ok, registry} = MixEx.Registry.start_link(manager)

		GenEvent.add_mon_handler(manager, Forwarder, self())
		{:ok, registry: registry}
	end

	test "registry is initially empty", %{registry: registry} do
		assert MixEx.Registry.lookup(registry, "shopping") == :error
	end

	test "spawns buckets", %{registry: registry} do
		MixEx.Registry.create(registry, "shopping")
		assert {:ok, _bucket} = MixEx.Registry.lookup(registry, "shopping")
	end

	test "removes buckets on exit", %{registry: registry} do
		MixEx.Registry.create(registry, "shopping")
		{:ok, bucket} = MixEx.Registry.lookup(registry, "shopping")
		Agent.stop(bucket)
		assert MixEx.Registry.lookup(registry, "shopping") == :error
	end

	test "sends events on create or crash", %{registry: registry} do
		MixEx.Registry.create(registry, "shopping")
		{:ok, bucket} = MixEx.Registry.lookup(registry, "shopping")
		assert_receive {:create, "shopping", ^bucket}

		Agent.stop(bucket)
		assert_receive {:exit, "shopping", ^bucket}
	end
end