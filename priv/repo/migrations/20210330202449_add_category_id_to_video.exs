defmodule Hello.Repo.Migrations.AddCategoryIdToVideo do
  use Ecto.Migration

  def change do
	alter table(:videos, prefix: "test") do
		add :category_id, references(:categories)
	end
  end
end
