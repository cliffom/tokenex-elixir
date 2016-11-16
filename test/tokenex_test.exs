defmodule TokenExTest do
  use ExUnit.Case

  test "tokenize a credit card" do
    cc_num = "4242424242424242"
    config = TokenEx.new_config(System.get_env("TOKENEX_ID"), System.get_env("TOKENEX_API_KEY"))

    {:ok, token_response} = TokenEx.tokenize(cc_num, 1, config)
    token = token_response.body["Token"]

    {:ok, value_response} = TokenEx.detokenize(token, config)
    value = value_response.body["Value"]

    assert value == cc_num
  end
end
