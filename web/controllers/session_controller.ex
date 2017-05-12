defmodule Myuserinfo.SessionController do
  use Myuserinfo.Web, :controller

  alias Myuserinfo.Userinf

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case login(session_params, Myuserinfo.Repo) do
      {:ok, user} ->
        conn
        #|> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: user_path(conn, :show, user.user_id))
      :error ->
        conn
        |> put_flash(:info, "Wrong Mobile No. or Password")
        |> render("new.html")
    end
  end

  def login(params, repo) do
      user = repo.get_by(Userinf, mobile: params["mobile"])
      if user do
          if user.password == params["password"] do
            {:ok, user}
          else
            :error
          end
      else
        :error
      end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/users")
  end

end
