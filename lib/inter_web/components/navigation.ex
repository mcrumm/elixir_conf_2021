defmodule InterWeb.Components.Navigation do
  @moduledoc """
  UI components for navigation elements.
  """
  use Phoenix.Component
  use Phoenix.HTML

  @doc """
  Renders a breadcrumb list item/link.
  """
  def breadcrumbs(assigns) do
    ~H"""
    <nav aria-label="Breadcrumb" class="breadcrumb">
      <ol><%= for breadcrumb <- @breadcrumb do %>
      <li><%= link render_slot(breadcrumb), to: breadcrumb.to %></li>
      <% end %></ol>
    </nav>
    """
  end

  @doc """
  Renders a breadcrumbs list with live redirect links.
  """
  def live_breadcrumbs(assigns) do
    ~H"""
    <nav aria-label="Breadcrumb" class="breadcrumb">
      <ol><%= for breadcrumb <- @breadcrumb do %>
      <li><%= live_redirect render_slot(breadcrumb), to: breadcrumb.to %></li>
      <% end %></ol>
    </nav>
    """
  end
end
