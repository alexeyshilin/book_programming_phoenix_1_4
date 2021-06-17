
defmodule HelloWeb.AnnotationView do
  use HelloWeb, :view

  def render("annotation.json", %{annotation: annotation}) do
    %{
      id: annotation.id,
      body: annotation.body,
      at: annotation.at,
      user: render_one(annotation.user, HelloWeb.UserView, "user.json")
    }
  end
end
