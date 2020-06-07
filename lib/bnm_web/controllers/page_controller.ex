defmodule BnmWeb.PageController do
  use BnmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
