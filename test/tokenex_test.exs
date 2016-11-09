defmodule TokenExTest do
  use ExUnit.Case

  test "tokenize a credit card" do
    config = TokenEx.new_config(System.get_env("TOKENEX_ID"), System.get_env("TOKENEX_API_KEY"))
    {:ok, response} = TokenEx.tokenize("4242424242424242", 1, config)
  end
end
