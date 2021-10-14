defmodule InterWeb.PageController do
  use InterWeb, :controller

  def index(conn, _params) do
    conn
    |> put_session("inside", true)
    |> render("index.html")
  end
end
