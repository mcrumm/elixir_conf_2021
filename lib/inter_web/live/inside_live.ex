defmodule InterWeb.InsideLive do
  use InterWeb, :live_view

  def mount(_, _, socket) do
    {:ok, redirect(socket, to: Routes.inside_mount_path(socket, :index))}
  end

  def render(assigns), do: ~H""
end
