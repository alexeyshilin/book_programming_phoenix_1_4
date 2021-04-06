defmodule Hello.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "test"
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
#    field :user_id, :id
    belongs_to :user, Hello.Accounts.User
    belongs_to :category, Hello.Multimedia.Category

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
  end
end
