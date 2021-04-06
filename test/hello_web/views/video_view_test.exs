
defmodule HelloWeb.VideoViewTest do
  use HelloWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do 
    videos = [
      %Hello.Multimedia.Video{id: "1", title: "dogs"},
      %Hello.Multimedia.Video{id: "2", title: "cats"}
    ]

    content = render_to_string(
      HelloWeb.VideoView, 
      "index.html", 
      conn: conn, 
      videos: videos)

    assert String.contains?(content, "Listing Videos")

    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do 
    owner = %Hello.Accounts.User{}
    changeset = Hello.Multimedia.change_video(%Hello.Multimedia.Video{})
    categories = [%Hello.Multimedia.Category{id: 123, name: "cats"}]

    content =
      render_to_string(HelloWeb.VideoView, "new.html",
        conn: conn,
        changeset: changeset,
        categories: categories
      )

    assert String.contains?(content, "New Video")
  end
end


# mix test test/hello_web/views/video_view_test.exs