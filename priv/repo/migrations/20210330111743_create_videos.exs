defmodule Hello.Repo.Migrations.CreateVideos do
  use Ecto.Migration

#  def change do
#
#  end

  def up do
    create table(:videos, prefix: "test") do
      add :url, :string
      add :title, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:videos, [:user_id], prefix: "test")
  end

  def down do
    drop table(:videos, prefix: "test")
  end

end
