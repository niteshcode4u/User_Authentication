defmodule Myuserinfo.UserController do
  use Myuserinfo.Web, :controller

  alias Myuserinfo.User
  alias Myuserinfo.Userinf

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    changeset2 = Userinf.changeset(%Userinf{})
    render(conn, "new.html", changeset: changeset, changeset2: changeset2)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        user_params = Map.put(user_params, "user_id" , user.id)
        changeset2 = Userinf.changeset(%Userinf{}, user_params)
        case Repo.insert(changeset2) do
          {:ok, _user} ->
            conn
            #|> put_session(:current_user, changeset.id)
            |> put_flash(:info, "Hey we have received your details.")
            |> redirect(to: user_path(conn, :index))
          {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        user2 = Repo.get_by(Userinf, user_id: id)
        changeset2 = Userinf.changeset(user2, user_params)
        case Repo.update(changeset2) do
          {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: user_path(conn, :show, user))
          {:error, changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
        end
        {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "id" => user_id}) do
    user2 = Repo.get!(Userinf, user_id)
    user  = Repo.get!(User, id)
    Repo.delete!(user2)
    Repo.delete!(user)
    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

end
