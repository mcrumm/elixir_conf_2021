defmodule InterWeb.InsideLive.LiveSessions do
  use InterWeb, :live_view

  router_path = Path.join([__DIR__, "..", "..", "router.ex"])
  @external_resource router_path
  @router_ex File.read!(router_path)

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:router_ex, @router_ex)}
  end
end
