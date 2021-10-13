defmodule InterWeb.InsideLive.LifecycleHooks do
  @moduledoc """
  The sixth and final vignette covers the new lifecycle hooks.
  """
  use InterWeb, :live_view

  live_recompiler_path = Path.join([__DIR__, "..", "..", "live_recompiler.ex"])
  @external_resource live_recompiler_path
  @live_recompiler File.read!(live_recompiler_path)

  contenteditable_path =
    Path.join([__DIR__, "..", "..", "..", "..", "assets", "js", "hooks", "contenteditable.js"])

  @external_resource contenteditable_path
  @content_editable File.read!(contenteditable_path)

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok, assign(socket, live_recompiler: @live_recompiler, content_editable: @content_editable)}
  end
end
