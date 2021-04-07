defmodule Hello.Repo.Migrations.AddSlugToVideos do
  use Ecto.Migration

  def change do
	alter table(:videos, prefix: "test") do
		add :slug, :string
	end
  end
end

# mix ecto.gen.migration add_slug_to_videos
# mix ecto.migrate
