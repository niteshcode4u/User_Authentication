defmodule Myuserinfo.PageController do
  use Myuserinfo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
