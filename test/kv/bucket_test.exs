defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end

  test "initial state is empty", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "stores a value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes a key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 1337)
    deleted = KV.Bucket.delete(bucket, "milk")
    assert deleted == 1337
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
