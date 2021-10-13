defmodule InterWeb.Components.Inspector do
  @moduledoc """
  Naive source code loader.
  """
  use Phoenix.Component
  use Phoenix.HTML
  import PhoenixWeb.Profiler, only: [dump: 1], warn: false

  require Makeup.Styles.HTML.StyleMap
  alias Makeup.Styles.HTML.StyleMap

  @doc """
  Rends a component to introspect the current module.
  """
  def code_inspector(assigns) do
    # Note: this is a terrible thing to do at runtime.
    # If you wanted to do something like this for real,
    # read the files at compile-time and save the content
    # somewhere– I was in a hurry. please forgive me (-:
    assigns =
      assigns
      |> Map.put_new(:open, false)
      |> Map.put(:stylesheet, Makeup.stylesheet(StyleMap.monokai_style()))
      |> Map.update!(:file, fn file ->
        file |> File.read!() |> Makeup.highlight()
      end)

    ~H"""
    <style type="text/css"><%= raw(@stylesheet) %></style>
    <details open={@open}><summary>View Source</summary>
    <%= raw(@file) %>
    </details>
    """
  end
end
