defmodule HelloWeb.UserView do
  use HelloWeb, :view

  alias Hello.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
