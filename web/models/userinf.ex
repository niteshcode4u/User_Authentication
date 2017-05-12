defmodule Myuserinfo.Userinf do
  use Myuserinfo.Web, :model

  schema "userinfs" do
    field :password, :string
    field :mobile, :integer
    belongs_to :user, Myuserinfo.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password, :mobile, :user_id])
    |> validate_required([:password, :mobile])
    |> validate_length(:password, min: 6)
    |> validate_length(:password, max: 25)
    |> unique_constraint(:mobile)
  end
end
