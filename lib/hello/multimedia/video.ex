defmodule Hello.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "test"
  @primary_key {:id, Hello.Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
#    field :user_id, :id
    belongs_to :user, Hello.Accounts.User
    belongs_to :category, Hello.Multimedia.Category
    field :slug, :string

    has_many :annotations, Rumbl.Multimedia.Annotation

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

end
