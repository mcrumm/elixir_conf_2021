defmodule InterWeb.Components.Colors do
  @moduledoc """
  Functional components for color pickers et cetera.
  """
  use Phoenix.Component

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
      |> Map.put_new(:step, 5)

    ~H"""
    <div class="control">
      <label for={"color-#{@name}"}><%= @name %></label>
      <input
        type="range"
        id={rgb_slider_id(@name)}
        name={rgb_slider_name(@name)}
        min="0" max="255"
        value={@value}
        step={@step}>
    </div>
    """
  end

  def rgb_slider_id(name) do
    Phoenix.HTML.Form.input_id(:color, name)
  end

  def rgb_slider_name(name) do
    Phoenix.HTML.Form.input_name(:color, name)
  end
end
