defmodule StudioSuperadminWeb.Router do
  use StudioSuperadminWeb, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, use_config: {:studio_superadmin, :basic_auth}
  end

  scope "/", ExAdmin do
    pipe_through :browser
    admin_routes()
  end

end
