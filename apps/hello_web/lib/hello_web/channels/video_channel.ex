
defmodule HelloWeb.VideoChannel do
  use HelloWeb, :channel

  alias Hello.{Accounts, Multimedia}

  alias HelloWeb.AnnotationView

  def join("videos:" <> video_id, params, socket) do
    send(self(), :after_join) # will be handled by handle_info
    last_seen_id = params["last_seen_id"] || 0
    video_id = String.to_integer(video_id)
    video = Multimedia.get_video!(video_id)

    annotations = []

    annotations =
      video
      |> Multimedia.list_annotations(last_seen_id)
      |> Phoenix.View.render_many(AnnotationView, "annotation.json")

      IO.puts "annotations"

    {:ok, %{annotations: annotations}, assign(socket, :video_id, video_id)}
  end

#	def handle_info(:ping, socket) do
#		count = socket.assigns[:count] || 1
#		push(socket, "ping", %{count: count})
#
#		{:noreply, assign(socket, :count, count + 1)}
#	end

  def handle_info(:after_join, socket) do 
    push(socket, "presence_state", HelloWeb.Presence.list(socket))
    {:ok, _} = HelloWeb.Presence.track(
      socket, 
      socket.assigns.user_id, 
      %{device: "browser"})
    {:noreply, socket}
  end

  def handle_in(event, params, socket) do 
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in_("new_annotation", params, user, socket) do 
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

  def handle_in("new_annotation", params, user, socket) do
    case Multimedia.annotate_video(user, socket.assigns.video_id, params) do
      {:ok, annotation} ->
        broadcast_annotation(socket, user, annotation) 
        Task.start(fn -> compute_additional_info(annotation, socket) end) 
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp broadcast_annotation(socket, user, annotation) do  
    broadcast!(socket, "new_annotation", %{
      id: annotation.id,
      user: HelloWeb.UserView.render("user.json", %{user: user}),
      body: annotation.body,
      at: annotation.at
    })
  end

  defp compute_additional_info(annotation, socket) do
    for result <- 
      InfoSys.compute(annotation.body, limit: 1, timeout: 10_000) do
        
      backend_user = Accounts.get_user_by(username: result.backend.name())
      attrs = %{body: result.text, at: annotation.at}

      case Multimedia.annotate_video(
        backend_user, annotation.video_id, attrs) do

        {:ok, info_ann} -> 
          broadcast_annotation(socket, backend_user, info_ann)
        {:error, _changeset} -> :ignore
      end
    end
  end

end
