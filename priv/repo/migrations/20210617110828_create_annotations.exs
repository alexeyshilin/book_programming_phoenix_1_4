defmodule Hello.Repo.Migrations.CreateAnnotations do
  use Ecto.Migration

  def change do
    create table(:annotations, prefix: "test") do
      add :body, :text
      add :at, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :video_id, references(:videos, on_delete: :nothing)

      timestamps()
    end

    create index(:annotations, [:user_id], prefix: "test")
    create index(:annotations, [:video_id], prefix: "test")
  end
end

# MIX_ENV=dev /usr/local/share/libs/elixir-1.11.4/bin/mix ecto.migrate
