defmodule InterWeb.InsideLive.Navigation do
  use InterWeb, :live_view
  alias InterWeb.Colors

  @colors ~w(red green blue)

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    color = :phoenix |> Colors.color() |> Colors.darken(30) |> Colors.rgb()
    {:ok, assign(socket, color: color, changes: 0)}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :color, %{"name" => color})
       when color in @colors do
    {:noreply, socket |> assign(:color, color) |> update(:changes, &(&1 + 1))}
  end

  defp apply_action(socket, _, _) do
    {:noreply, socket}
  end
end
