defmodule TokenEx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://test-api.tokenex.com/TokenServices.svc/REST"
  plug Tesla.Middleware.JSON

  adapter :hackney, [ssl_options: [{:versions, [:'tlsv1.2']}]]

  def new_config(id, api_key) do
    %{"TokenExID" => id,
      "APIKey" => api_key}
  end

  def make_request(action, request) do
    response = post(action, request)
    {:ok, response}
  end

  def tokenize(data, token_scheme, config) do
    request = %{"Data" => data,
      "TokenScheme" => token_scheme} |> Map.merge(config)

    make_request("/Tokenize", request)
  end

  def detokenize(token, config) do
    request = %{"Token" => token} |> Map.merge(config)

    make_request("/Detokenize", request)
  end
end
