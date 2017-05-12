defmodule Myuserinfo.Repo.Migrations.CreateUserinf do
  use Ecto.Migration

  def change do
    create table(:userinfs) do
      add :password, :string
      add :mobile, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:userinfs, [:user_id])

  end
end
