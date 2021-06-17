
defmodule HelloWeb.VideoChannel do
  use HelloWeb, :channel

  alias Hello.{Accounts, Multimedia}

  def join("videos:" <> video_id, _params, socket) do
    {:ok, assign(socket, :video_id, String.to_integer(video_id))}

#    :timer.send_interval(5_000, :ping)
#    {:ok, socket}

  end

#	def handle_info(:ping, socket) do
#		count = socket.assigns[:count] || 1
#		push(socket, "ping", %{count: count})
#
#		{:noreply, assign(socket, :count, count + 1)}
#	end

  def handle_in(event, params, socket) do 
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in("new_annotation", params, user, socket) do 
    case Multimedia.annotate_video(user, socket.assigns.video_id, params) do
      {:ok, annotation} ->
        broadcast!(socket, "new_annotation", %{
          id: annotation.id,
          user: HelloWeb.UserView.render("user.json", %{user: user}), 
          body: annotation.body,
          at: annotation.at
        })
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

end
