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
    params = %{"Data" => data,
      "TokenScheme" => token_scheme}
    make_request("Tokenize", params, config)
  end

  def detokenize(token, config) do
    params = %{"Token" => token}
    make_request("Detokenize", params, config)
  end

  defp make_request(action, data, config) do
    request = data |> Map.merge(config)
    post(action, request) |> get_response
  end

  defp get_response(response) do
    case response.status do
      200 ->
        status =
          case response.body["Success"] do
            true  -> :ok
            false -> :error
          end
        {status, response.body}

      _ -> {:error, %{"Error" => "Invalid HTTP status code: " <> Integer.to_string(response.status)}}
    end
  end
end
