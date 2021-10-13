defmodule InterWeb.InsideLive.Navigation do
  use InterWeb, :live_view

  @colors ~w(red green blue)

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, color: "teal", changes: 0)}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :color, %{"name" => color})
       when color in @colors do
    {:noreply, socket |> assign(:color, color) |> update(:changes, &(&1 + 1))}
  end

  defp apply_action(socket, :index, _) do
    {:noreply, socket}
  end
end
