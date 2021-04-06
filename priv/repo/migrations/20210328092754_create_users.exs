defmodule Hello.Repo.Migrations.CreateUsers do
  use Ecto.Migration

#  def change do
#  		create table(:users) do
#  			add :name, :string
#  			add :username, :string, null: false
#  			add :password_hash, :string
#
#  			timestamps()
#  		end
#
#  		create unique_index(:users, [:username])
#  end

  def up do
  		#create table(:users) do
  		create table(:users, prefix: "test") do # or use prefix param to set some schema differs than public schema
  			add :name, :string
  			add :username, :string, null: false
  			add :password_hash, :string

  			timestamps()
  		end

  		create unique_index(:users, [:username], prefix: "test")
  end

	def down do
		drop table(:users, prefix: "test")
	end

end
