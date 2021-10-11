defmodule InterWeb.PageController do
  use InterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
