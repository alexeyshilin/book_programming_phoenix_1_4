defmodule Hello.Repo.Migrations.SomeMigrationName do
  use Ecto.Migration

#  def change do
#
#  end


  def up do
	  alter table(:users, prefix: "test") do
	    add :password, :text
#	    add :password_hash, :text
	  end
  end

	def down do
	  alter table(:users, prefix: "test") do
	    remove :password
#	    remove :password_hash
	  end
	end


end
