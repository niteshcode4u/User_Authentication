defmodule Myuserinfo.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :age, :integer
      add :sex, :string

      timestamps()
    end

  end
end
