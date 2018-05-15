defmodule SSHeroWeb.Router do
  use SSHeroWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SSHeroWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/deploy", PageController, :deploy
  end

  # Other scopes may use custom stacks.
  # scope "/api", SSHeroWeb do
  #   pipe_through :api
  # end
end
