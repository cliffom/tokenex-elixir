defmodule TokenEx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://test-api.tokenex.com/TokenServices.svc/REST"
  plug Tesla.Middleware.JSON

  def new_config(id, api_key) do
    %{"TokenExID" => id,
      "APIKey" => api_key}
  end

  def tokenize(data, token_scheme, config) do
    request = %{"Data" => data,
      "TokenScheme" => token_scheme} |> Map.merge(config)

    IO.inspect (request)
    response = post("/Tokenize", request)
    {:ok, %{}}
  end
end
