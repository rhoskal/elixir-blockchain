defmodule Crypto do
  # Specify which fields to hash in the block
  @hash_fields [:data, :timestamp, :prev_hash]

  @doc "Calculate the hash of a block"
  def hash(%{} = block) do
    block
    |> Map.take(@hash_fields)
    |> Jason.encode!
    |> sha256
  end

  @doc "Calculate and put the hash in the block"
  def append_hash(%{} = block) do
    %{ block | hash: hash(block) }
  end

  defp sha256(binary) do
    :crypto.hash(:sha256, binary) |> Base.encode16
  end
end
