defmodule InterWeb.InsideLive.NavigationRedirect do
  use InterWeb, :live_view
  alias InterWeb.Colors

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :index, _), do: {:noreply, socket}

  defp apply_action(socket, :color_phx, _) do
    {:noreply,
     socket
     |> push_redirect(to: Colors.color_path(socket, :phx))}
  end

  defp apply_action(socket, :color_ex, _) do
    {:noreply,
     socket
     |> push_redirect(to: Colors.color_path(socket, :ex))}
  end
end
