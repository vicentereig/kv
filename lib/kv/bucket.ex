defmodule KV.Bucket do
  use Agent

  # The agent passes its state to the anonymous function via the
  # `&1` argument when `Agent.get/2` and `Agent.update/2` are called.
  def start_link(_opts) do
    Agent.start_link(fn -> %{}  end)
  end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end
end
