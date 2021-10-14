defmodule InterWeb.InsideLive.Mount do
  use InterWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_new(:useragent, fn ->
        get_connect_info(socket)[:useragent]
      end)
      |> assign_new(:lang, fn ->
        get_connect_params(socket)["lang"]
      end)

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="row inspector">
      <section class="column">
        <.code_editor id="messages-inspector" contents={@contents} />
      </section>
    </section>
    """
  end
end
