
defmodule InfoSys.Wolfram do
  import SweetXml
  alias InfoSys.Result

  @behaviour InfoSys.Backend 

  @base "http://api.wolframalpha.com/v2/query"

  @impl true
  def name, do: "wolfram"

  @impl true
  def compute(query_str, _opts) do 
    query_str
    |> fetch_xml()
    |> xpath(~x"/queryresult/pod[contains(@title, 'Result') or
                                 contains(@title, 'Definitions')]
                            /subpod/plaintext/text()")
    |> build_results()
  end

  defp build_results(nil), do: [] 

  defp build_results(answer) do
    [%Result{backend: __MODULE__, score: 95, text: to_string(answer)}]
  end

  @http Application.get_env(:info_sys, :wolfram)[:http_client] || :httpc   
  defp fetch_xml(query) do
    {:ok, {_, _, body}} = @http.request(String.to_charlist(url(query)))

    body
  end

  defp url(input) do
    "#{@base}?" <> 
    URI.encode_query(appid: id(), input: input, format: "plaintext")
  end

  defp id, do: Application.fetch_env!(:info_sys, :wolfram)[:app_id]

end


# mix deps.get
# MIX_ENV=dev WOLFRAM_APP_ID=test /usr/local/share/libs/elixir-1.11.4/bin/iex -S mix
# InfoSys.compute("what is elixir?")
# InfoSys.compute("what is firebird?")
# flush()

# MIX_ENV=dev WOLFRAM_APP_ID=test /usr/local/share/libs/elixir-1.11.4/bin/iex -S mix
# pid = spawn(fn -> :ok end)
# Process.monitor(pid)
# flush()