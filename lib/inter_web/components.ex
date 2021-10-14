defmodule InterWeb.Components do
  @moduledoc """
  Some UI components.
  """
  use Phoenix.Component

  defdelegate code_editor(assigns), to: InterWeb.Components.Inspector

  defdelegate code_inspector(assigns), to: InterWeb.Components.Inspector

  defdelegate rgb_slider(assigns), to: InterWeb.Components.Colors

  defdelegate breadcrumbs(assigns), to: InterWeb.Components.Navigation

  defdelegate live_breadcrumbs(assigns), to: InterWeb.Components.Navigation
end
