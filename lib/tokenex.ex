defmodule TokenEx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://test-api.tokenex.com/TokenServices.svc/REST"
  plug Tesla.Middleware.JSON

  adapter :hackney, [ssl_options: [{:versions, [:'tlsv1.2']}]]

  def new_config(id, api_key) do
    %{"TokenExID" => id,
      "APIKey" => api_key}
  end

  def tokenize(data, token_scheme, config) do
    request = %{"Data" => data,
      "TokenScheme" => token_scheme} |> Map.merge(config)

    response = post("/Tokenize", request)
    {:ok, response}
  end

  def detokenize(token, config) do
    request = %{"Token" => token} |> Map.merge(config)

    response = post("/Detokenize", request)
    {:ok, response}
  end
end
