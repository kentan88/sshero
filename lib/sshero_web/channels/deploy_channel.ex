defmodule SSHeroWeb.DeployChannel do
  use Phoenix.Channel
  alias Porcelain.Process, as: Proc
  alias Porcelain.Result

  def join("deploy", _payload, socket) do
    {:ok, %{hello: "world"}, socket}
  end

  def handle_in("upgrade", %{"branch" => branch}, socket) do
    IO.puts("Upgrading #{branch}...")

    opts = [out: :stream]
    proc = %Proc{out: outstream} = Porcelain.spawn("mix", ["edeliver", "upgrade", "production"], opts)
    Enum.each(outstream, fn(msg) ->
      broadcast! socket, "new:msg", %{msg: msg}
    end)

    {:reply, {:ok, %{}}, socket}
  end
end
