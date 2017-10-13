defmodule StudioSuperadminWeb.PageController do
  use StudioSuperadminWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
