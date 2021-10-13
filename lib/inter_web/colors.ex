defmodule InterWeb.Colors do
  @moduledoc """
  Conveniences for working with color values.
  """
  alias Inter.RGB
  alias InterWeb.Router.Helpers, as: Routes

  @type builtin_color :: :elixir | :phoenix

  @colors %{
    elixir: {75, 68, 115},
    phoenix: {242, 110, 64}
  }

  @doc """
  Returns the color for a given `name`.
  """
  @spec color(name :: builtin_color) :: RGB.t()
  for {key, {r, g, b}} <- @colors do
    def color(unquote(key)), do: %RGB{red: unquote(r), green: unquote(g), blue: unquote(b)}
  end

  @doc """
  Route meta-helper for the path to a given `color`.
  """
  @spec color_path(socket :: Phoenix.LiveView.Socket.t(), color :: RGB.t() | atom) :: String.t()
  def color_path(socket, color) when is_atom(color), do: color_path(socket, color(color))

  def color_path(socket, %RGB{red: r, green: g, blue: b}) do
    Routes.inside_events_path(socket, :color, r, g, b)
  end

  @doc """
  Returns a color struct for the given `params`.
  """
  defdelegate new(params), to: RGB

  @doc """
  Returns the rgb string for a given `color`.
  """
  def rgb(%RGB{red: r, green: g, blue: b}) do
    "rgb(#{r},#{g},#{b})"
  end

  @doc """
  Returns the color darkened by a given `amount`.
  """
  def darken(%RGB{} = color, amount)
      when is_integer(amount) and amount >= 0 and amount <= 255 do
    attrs =
      for {k, v} <- Map.from_struct(color),
          v >= amount,
          v <= 255,
          into: %{},
          do: {k, v - amount}

    RGB.new(attrs)
  end
end
