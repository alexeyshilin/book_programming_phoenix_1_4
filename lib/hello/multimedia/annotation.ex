defmodule Hello.Multimedia.Annotation do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "test"
  schema "annotations" do
    field :at, :integer
    field :body, :string
    field :user_id, :id
    field :video_id, :id

    timestamps()
  end

  @doc false
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
