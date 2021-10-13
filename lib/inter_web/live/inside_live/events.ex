defmodule InterWeb.InsideLive.Events do
  @moduledoc """
  The third vignette covers the handle_event callback.
  """
  use InterWeb, :live_view
  alias Inter.RGB
  alias InterWeb.Colors

  @impl Phoenix.LiveView
  def mount(params, _session, socket) when params == %{} do
    {:ok,
     push_redirect(socket,
       to: Colors.color_path(socket, RGB.random())
     )}
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("change-color", %{"color" => params}, socket) do
    {:noreply,
     push_patch(socket,
       replace: true,
       to: Colors.color_path(socket, RGB.new(params))
     )}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :color, params) do
    {:noreply, assign(socket, :rgb, RGB.new(params))}
  end

  defp apply_action(socket, :index, _) do
    {:noreply, socket}
  end
end
