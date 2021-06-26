
# {:ok, _} = Hello.Accounts.create_user(%{name: "Wolfram", username: "wolfram"})
{:ok, _} = Hello.Accounts.create_user(%{name: "Wolfram", username: "wolfram", password: "1234567"})

# MIX_ENV=dev WOLFRAM_APP_ID=test /usr/local/share/libs/elixir-1.11.4/bin/mix deps.get
# MIX_ENV=dev WOLFRAM_APP_ID=test /usr/local/share/libs/elixir-1.11.4/bin/mix run priv/repo/backend_seeds.exs

