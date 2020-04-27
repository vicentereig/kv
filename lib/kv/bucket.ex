defmodule KV.Bucket do
  use Agent

  # The agent passes its state to the anonymous function via the
  # `&1` argument when `Agent.get/2` and `Agent.update/2` are called.
  def start_link(_opts) do
    Agent.start_link(fn ->
      %{}
    end)
  end

  def get(bucket, key) do
    Agent.get(bucket, fn  state ->
      Map.get(state, key)
    end)
  end

  def put(bucket, key, value) do
    Agent.update(bucket, fn state ->
      Map.put(state, key, value)
    end)
  end

  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn state ->
      Map.pop(state, key)
    end)
  end
end
