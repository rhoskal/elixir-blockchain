defmodule Block do
  defstruct [:data, :timestamp, :prev_hash, :hash]

  @doc "Build a new block for given data and previous hash"
  def new(data, prev_hash) do
    %__MODULE__{
      data: data,
      prev_hash: prev_hash,
      timestamp: NaiveDateTime.utc_now
    }
  end

  @doc "Build the initial block of the chain"
  def zero do
    %__MODULE__{
      data: "HELLO_MASTER",
      prev_hash: "CHECK_POINT",
      timestamp: NaiveDateTime.utc_now
    }
  end

  @doc "Check if a block is valid"
  def valid?(%__MODULE__{} = block) do
    Crypto.hash(block) == block.hash
  end

  def valid?(%__MODULE__{} = block, %__MODULE__{} = prev_block) do
    (block.prev_hash == prev_block.hash) && valid?(block)
  end
end
