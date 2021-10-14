defmodule InterWeb.OutsideLive do
  use InterWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <p><%= link "Go Inside", to: Routes.page_path(InterWeb.Endpoint, :index) %></p>
    """
  end
end
