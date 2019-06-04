defmodule Blockchain do
  @moduledoc """
  Naive blockchain implementation via
  https://sheharyar.me/blog/writing-blockchain-elixir/
  """

  @doc "Create a new blockchain with a zero block" 
  def new do
    [ Crypto.append_hash(Block.zero) ] 
  end

  @doc "Insert given data as a new block in the blockchain"
  def insert(blockchain, data) when is_list(blockchain) do
    %Block{hash: prev} = hd(blockchain)

    block = 
      data
      |> Block.new(prev)
      |> Crypto.append_hash

    [ block | blockchain ]
  end

  @doc "Validate the complete blockchain"
  def valid?(blockchain) when is_list(blockchain) do
    zero = Enum.reduce_while(blockchain, nil, fn prev, current ->
      cond do
        current == nil ->
          {:cont, prev}

        Block.valid?(current, prev) ->
          {:cont, prev}

        true ->
          {:halt, false}
      end
    end)

    if zero, do: Block.valid?(zero), else: false
  end
end
