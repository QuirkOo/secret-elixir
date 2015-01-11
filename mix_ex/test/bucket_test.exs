defmodule MixEx.BucketTest do
	use ExUnit.Case, async: true

	test "stores values by key" do
		{:ok, bucket} = MixEx.Bucket.start_link
		assert MixEx.Bucket.get(bucket, "milk") == nil

		MixEx.Bucket.put(bucket, "milk", 3)
		assert MixEx.Bucket.get(bucket, "milk") == 3
	end
end
