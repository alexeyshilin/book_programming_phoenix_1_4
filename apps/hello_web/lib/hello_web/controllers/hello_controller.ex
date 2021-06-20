defmodule HelloWeb.HelloController do
	use HelloWeb, :controller

	def world2(conn, %{"name" => name}) do
		IO.puts "val"
		IO.puts name
		render(conn, "world2.html", name: name)
	end

	def world(conn, _params) do
		render(conn, "world.html")
	end
end