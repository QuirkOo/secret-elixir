defmodule MixEx.BucketTest do
	use ExUnit.Case, async: true

	setup do
		{:ok, bucket} = MixEx.Bucket.start_link
		{:ok, bucket: bucket}
	end

	test "stores values by key", %{bucket: bucket} do
		assert MixEx.Bucket.get(bucket, "milk") == nil

		MixEx.Bucket.put(bucket, "milk", 3)
		assert MixEx.Bucket.get(bucket, "milk") == 3
	end
end
