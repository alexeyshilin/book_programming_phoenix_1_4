
defmodule HelloWeb.Channels.VideoChannelTest do
  use HelloWeb.ChannelCase
  import HelloWeb.TestHelpers

  setup do 
    user = insert_user(name: "Gary") 
    video = insert_video(user, title: "Testing")
    token = Phoenix.Token.sign(@endpoint, "user socket", user.id)
    {:ok, socket} = connect(HelloWeb.UserSocket, %{"token" => token})

    {:ok, socket: socket, user: user, video: video}
  end

  test "join replies with video annotations", 
       %{socket: socket, video: vid, user: user} do 
    for body <- ~w(one two) do 
      Hello.Multimedia.annotate_video(user, vid.id, %{body: body, at: 0})
    end
    {:ok, reply, socket} = subscribe_and_join(socket, "videos:#{vid.id}", %{})

    assert socket.assigns.video_id == vid.id
    assert %{annotations: [%{body: "one"}, %{body: "two"}]} = reply
  end
end

# mix test test/hello_web/channels/video_channel_test.exs
