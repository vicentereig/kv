defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "initial state is empty" do
    {:ok, bucket} = KV.Bucket.start_link([])
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "stores a value by key" do
    {:ok, bucket} = KV.Bucket.start_link([])
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end
