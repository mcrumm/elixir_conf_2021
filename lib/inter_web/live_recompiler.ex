defmodule InterWeb.LiveRecompiler do
  # When you use InterWeb.LiveRecompiler a module can recompile itself in memory.
  # No one should ever do this for any reason.
  @moduledoc false
  import Phoenix.LiveView

  # LiveView lifecycle callback
  def on_mount(env, _params, _session, %{private: private} = socket) do
    socket = %{socket | private: Map.put(private, :live_recompiler_module, env)}

    socket =
      socket
      |> assign(:contents, File.read!(env.file))
      |> attach_hook(__MODULE__, :handle_event, &handle_content_changed/3)

    {:cont, socket}
  end

  defp handle_content_changed("contenteditable", %{"contents" => contents}, socket) do
    {:halt, apply_code_change(socket, contents)}
  end

  defp handle_content_changed(_, _, socket) do
    {:cont, socket}
  end

  # Note: this pretty dangerous. Consider *not* overwriting your modules with user input.
  defp apply_code_change(%{private: %{live_recompiler_module: module}} = socket, contents) do
    File.write!(module.file, contents)
    update(socket, :contents, fn _ -> contents end)
  end
end
