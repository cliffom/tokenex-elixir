defmodule TokenEx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://test-api.tokenex.com/TokenServices.svc/REST"
  plug Tesla.Middleware.JSON
  adapter :hackney, [ssl_options: [{:versions, [:'tlsv1.2']}]]

  def new_config(id, api_key) do
    %{"TokenExID" => id,
      "APIKey" => api_key}
  end

  def make_request(action, data, config) do
    request = data |> Map.merge(config)
    response = post(action, request)
    {:ok, response}
  end

  def tokenize(data, token_scheme, config) do
    params = %{"Data" => data,
      "TokenScheme" => token_scheme}
    make_request("Tokenize", params, config)
  end

  def detokenize(token, config) do
    params = %{"Token" => token}
    make_request("Detokenize", params, config)
  end
end
