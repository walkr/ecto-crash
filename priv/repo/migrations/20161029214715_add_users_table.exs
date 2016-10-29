defmodule EctoCrash.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    # execute("CREATE EXTENSION IF NOT EXISTS postgis")

    create table(:users, primary_key: false) do

      add :id, :binary_id, primary_key: true
      add :username, :string
      add :profession, :string
    end

    create unique_index(:users, [:username])
  end
end
