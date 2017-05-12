defmodule Myuserinfo.User do
  use Myuserinfo.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :age, :integer
    field :sex, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :age, :sex])
    |> validate_required([:name, :email, :age, :sex])
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:age, 18..100)
    |> unique_constraint(:email)
  end
end
