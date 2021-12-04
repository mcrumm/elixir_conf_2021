defmodule InterWeb.InsideLive.Messages do
  use InterWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, pid} =
      if connected?(socket) do
        Agent.start_link(fn -> :ok end)
      else
        {:ok, nil}
      end

    {:ok, assign(socket, agent: pid)}
  end

  @impl Phoenix.LiveView
  def handle_info({__MODULE__, msg}, socket) do
    {:noreply, assign(socket, :msg, msg)}
  end

  @impl Phoenix.LiveView
  def handle_event("send", %{"chat" => %{"msg" => msg}}, socket) do
    lv = self()
    :ok =
      Agent.update(socket.assigns.agent, fn _ ->
        Process.send_after(lv, {__MODULE__, msg}, 1_000)
      end)

    {:noreply, socket}
  end
end
