defmodule MixEx.RegistryTest do
	use ExUnit.Case, async: true

	setup do
		{:ok, registry} = MixEx.Registry.start_link
		{:ok, registry: registry}
	end

	test "registry is initially empty", %{registry: registry} do
		assert MixEx.Registry.lookup(registry, "shopping") == :error
	end

	test "spawns buckets", %{registry: registry} do
		MixEx.Registry.create(registry, "shopping")
		assert {:ok, _bucket} = MixEx.Registry.lookup(registry, "shopping")
	end
end