defmodule TokenExTest do
  use ExUnit.Case

  test "tokenize a credit card" do
    cc_num = "4242424242424242"
    config = TokenEx.new_config(System.get_env("TOKENEX_ID"), System.get_env("TOKENEX_API_KEY"))

    {token_status, token_response} = TokenEx.tokenize(cc_num, 1, config)
    token = token_response["Token"]

    {value_status, value_response} = TokenEx.detokenize(token, config)
    value = value_response["Value"]

    assert token_status === :ok
    assert value_status === :ok
    assert value == cc_num
  end

  test "it won't tokenize an invalid card number" do
    cc_num = "1234"
    config = TokenEx.new_config(System.get_env("TOKENEX_ID"), System.get_env("TOKENEX_API_KEY"))

    {status, _} = TokenEx.tokenize(cc_num, 1, config)

    assert status == :error
  end
end
