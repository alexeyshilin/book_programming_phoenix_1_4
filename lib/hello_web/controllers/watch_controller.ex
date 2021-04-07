

defmodule HelloWeb.WatchController do
use HelloWeb, :controller

alias Hello.Multimedia

def show(conn, %{"id" => id}) do
	video = Multimedia.get_video!(id)
	render(conn, "show.html", video: video)
end

end