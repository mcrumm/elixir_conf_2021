defmodule InterWeb.InsideLive.Mount do
  use InterWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_new(:useragent, fn ->
        get_connect_info(socket)[:user_agent]
      end)
      |> assign_new(:lang, fn ->
        get_connect_params(socket)["language"]
      end)

    {:ok, socket}
  end
end
