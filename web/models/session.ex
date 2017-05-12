defmodule Myuserinfo.Session do
  alias Myuserinfo.User
  #alias Myuserinfo.Userinf



  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Myuserinfo.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

end
