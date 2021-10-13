defmodule InterWeb.InsideLive.Events do
  @moduledoc """
  The third vignette covers the handle_event callback.
  """
  use InterWeb, :live_view
  alias InterWeb.Colors

  @impl Phoenix.LiveView
  def mount(params, _session, socket) when params == %{} do
    {:ok, assign(socket, changes: 0, rgb: Colors.color(:elixir))}
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, changes: 0)}
  end

  @impl Phoenix.LiveView
  def handle_event("change-color", %{"color" => params}, socket) do
    {:noreply,
     push_patch(socket,
       replace: true,
       to: Colors.color_path(socket, Colors.new(params))
     )}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :color, params) do
    {:noreply,
     socket
     |> assign(:rgb, Colors.new(params))
     |> update(:changes, &(&1 + 1))}
  end

  defp apply_action(socket, :index, _) do
    {:noreply, socket}
  end
end
