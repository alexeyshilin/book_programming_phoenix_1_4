defmodule Hello.Multimedia.Annotation do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "test"
  schema "annotations" do
    field :at, :integer
    field :body, :string
    #field :user_id, :id
    #field :video_id, :id
    belongs_to :user, Hello.Accounts.User
    belongs_to :video, Hello.Multimedia.Video

    timestamps()
  end

  @doc false
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
