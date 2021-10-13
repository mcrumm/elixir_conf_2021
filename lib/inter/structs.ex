defmodule Inter.RGB do
  @moduledoc """
  Data structure representing values of red, green, and blue.
  """
  defstruct red: 242, green: 110, blue: 64

  @type t :: %__MODULE__{
          red: 0..255,
          green: 0..255,
          blue: 0..255
        }

  def new(params) do
    attrs =
      Map.new(params, fn
        {"red", value} -> {:red, String.to_integer(value)}
        {"green", value} -> {:green, String.to_integer(value)}
        {"blue", value} -> {:blue, String.to_integer(value)}
        other -> other
      end)

    struct!(__MODULE__, attrs)
  end

  def random do
    new(%{
      red: Enum.random(0..255),
      green: Enum.random(0..255),
      blue: Enum.random(0..255)
    })
  end
end
