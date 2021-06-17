
defmodule HelloWeb.VideoChannel do
  use HelloWeb, :channel

  alias Hello.{Accounts, Multimedia}

  alias HelloWeb.AnnotationView

  def join("videos:" <> video_id, _params, socket) do
    video_id = String.to_integer(video_id)
    video = Multimedia.get_video!(video_id)

    annotations =
      video
      |> Multimedia.list_annotations()
      |> Phoenix.View.render_many(AnnotationView, "annotation.json")

    {:ok, %{annotations: annotations}, assign(socket, :video_id, video_id)}
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
