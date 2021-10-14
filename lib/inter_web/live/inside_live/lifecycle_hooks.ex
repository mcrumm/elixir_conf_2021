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

  navigation_path = Path.join([__DIR__, "..", "..", "navigation.ex"])
  @external_resource navigation_path
  @navigation_ex File.read!(navigation_path)

  navigation_component_path = Path.join([__DIR__, "..", "..", "components", "navigation.ex"])
  @external_resource navigation_component_path
  @navigation_component File.read!(navigation_component_path)

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign(:live_recompiler, @live_recompiler)
     |> assign(:content_editable, @content_editable)
     |> assign(:navigation_ex, @navigation_ex)
     |> assign(:navigation_component, @navigation_component)}
  end
end
