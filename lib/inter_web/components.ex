defmodule InterWeb.Components do
  @moduledoc """
  Some UI components.
  """
  use Phoenix.Component

  defdelegate code_editor(assigns), to: InterWeb.Components.Inspector

  defdelegate code_inspector(assigns), to: InterWeb.Components.Inspector

  @doc """
  Renders a range input for an rgb color (0-255).

  ## Assigns

    * `:name` - Required. The name of the color (e.g. `"red"`).

    * `:value` - The RGB value of the color (0-255). Defaults to `0`.

  """
  def rgb_slider(assigns) do
    assigns =
      assigns
      |> Map.put_new(:value, 0)
      |> Map.put_new(:step, 1)

    ~H"""
    <label for={"color-#{@name}"}><%= @name %></label>
    <input
      type="range"
      id={rgb_slider_id(@name)}
      name={rgb_slider_name(@name)}
      min="0" max="255"
      value={@value}
      step={@step}>
    """
  end

  def rgb_slider_id(name) do
    Phoenix.HTML.Form.input_id(:color, name)
  end

  def rgb_slider_name(name) do
    Phoenix.HTML.Form.input_name(:color, name)
  end
end
