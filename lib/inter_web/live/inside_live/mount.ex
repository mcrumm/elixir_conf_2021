defmodule InterWeb.InsideLive.Mount do
  @moduledoc """
  This is the first vignette. It covers the mount callback in both its
  disconnected and connected state.
  """
  use InterWeb, :live_view

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
