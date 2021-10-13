defmodule InterWeb.Components.Inspector do
  @moduledoc """
  Naive source code loader.
  """
  use Phoenix.Component
  use Phoenix.HTML

  require Makeup.Styles.HTML.StyleMap
  alias Makeup.Styles.HTML.StyleMap

  @stylesheet "<style type=\"text/css\">" <>
                Makeup.stylesheet(StyleMap.monokai_style()) <> "</style>"

  @doc """
  Rends a component to introspect the current module.
  """
  def code_inspector(assigns) do
    assigns =
      assigns
      |> Map.put_new(:summary, "View Source")
      |> Map.put(:stylesheet, @stylesheet)
      |> update(:contents, &(&1 |> Makeup.highlight() |> raw()))

    ~H"""
    <%= raw(@stylesheet) %>
    <details><summary><%= @summary %></summary>
    <div><%= @contents %></div>
    </details>
    """
  end

  @doc """
  Rends a component to introspect the current module.
  """
  def code_editor(assigns) do
    assigns =
      assigns
      |> Map.put(:stylesheet, @stylesheet)
      |> update(:contents, &(&1 |> Makeup.highlight() |> raw()))

    ~H"""
    <%= raw(@stylesheet) %>
    <details><summary>View Source</summary>
    <div id={@id} phx-hook="Contenteditable"><%= @contents %></div>
    </details>
    """
  end
end
