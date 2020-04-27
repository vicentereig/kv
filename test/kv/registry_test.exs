defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    _ = start_supervised!({KV.Registry, name: context.test})
    %{registry: context.test}
  end

  test "spawns buckets", %{registry: registry} do
    assert KV.Registry.lookup(registry, "shopping") == :error

    KV.Registry.create(registry, "shopping")
    assert {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    KV.Bucket.put(bucket, "milk", 2)
    assert KV.Bucket.get(bucket, "milk") == 2
  end

  test "remove an bucket on exit", %{registry: registry} do
    KV.Registry.create(registry,  "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

  test "remove bucket on crash", %{registry: registry} do
    KV.Registry.create(registry,  "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket, :shutdown)
    catch_exit KV.Bucket.put(bucket, "milk", 3)
  end
end
