defmodule Hello.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, prefix: "test") do
      add :name, :string

      timestamps()

    end

    create unique_index(:categories, [:name], prefix: "test")

  end
end
