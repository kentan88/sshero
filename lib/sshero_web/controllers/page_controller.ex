defmodule SSHeroWeb.PageController do
  use SSHeroWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def deploy(conn, _params) do
    render conn, "deploy.html"
  end
end
