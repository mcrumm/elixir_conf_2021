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
      <ol><%= for breadcrumb <- @breadcrumb, attrs = breadcrumb_attrs(breadcrumb, @for) do %>
      <li><%= link render_slot(breadcrumb), attrs %></li>
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
      <ol><%= for breadcrumb <- @breadcrumb, attrs = breadcrumb_attrs(breadcrumb, @for) do %>
      <li><%= live_redirect render_slot(breadcrumb), attrs %></li>
      <% end %></ol>
    </nav>
    """
  end

  defp breadcrumb_attrs(%{to: path}, current_path) do
    [to: path, aria_current: if(path == current_path, do: "page")]
  end
end
