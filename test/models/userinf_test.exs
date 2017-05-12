defmodule Myuserinfo.UserinfTest do
  use Myuserinfo.ModelCase

  alias Myuserinfo.Userinf

  @valid_attrs %{mobile: 42, password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Userinf.changeset(%Userinf{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Userinf.changeset(%Userinf{}, @invalid_attrs)
    refute changeset.valid?
  end
end
