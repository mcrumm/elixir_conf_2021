defmodule InterWeb.Navigation do
  import Plug.Conn
  alias InterWeb.Router.Helpers, as: Routes

  # Plug
  def assign_current_path(conn, _) do
    Plug.Conn.assign(
      conn,
      :current_path,
      Phoenix.Controller.current_path(conn)
    )
  end

  def on_mount(_, _, _, %{private: %{root_view: PhoenixProfiler.ToolbarLive}} = socket) do
    {:cont, socket}
  end

  # Lifecycle Hook
  def on_mount(:assign_current_path, _params, _session, socket) do
    {:cont,
     Phoenix.LiveView.attach_hook(socket, :assign_current_path, :handle_params, fn
       _params, url, socket ->
         {:cont,
          Phoenix.LiveView.assign_new(socket, :current_path, fn ->
            %URI{path: current_path} = URI.parse(url)
            current_path
          end)}
     end)}
  end

  # Lifecycle Hook
  def on_mount(:redirect_if_was_inside, _params, %{"inside" => _}, socket) do
    {:halt, socket |> put_flash_error() |> do_redirect_to_inside_live_sessions()}
  end

  def on_mount(:redirect_if_was_inside, _params, _session, socket) do
    {:cont, socket}
  end

  # Plug
  def redirect_if_was_inside(conn, _) do
    case get_session(conn, "inside") do
      nil ->
        conn

      _ ->
        conn |> put_flash_error() |> do_redirect_to_inside_live_sessions()
    end
  end

  @flash "🎶 Well well, look who's inside again 🎶"
  defp put_flash_error(conn_or_socket)

  defp put_flash_error(%Plug.Conn{} = conn) do
    Phoenix.Controller.put_flash(conn, :error, @flash)
  end

  defp put_flash_error(%Phoenix.LiveView.Socket{} = socket) do
    Phoenix.LiveView.put_flash(socket, :error, @flash)
  end

  defp do_redirect_to_inside_live_sessions(conn_or_socket)

  defp do_redirect_to_inside_live_sessions(%Plug.Conn{} = conn) do
    Phoenix.Controller.redirect(conn, to: live_sessions())
  end

  defp do_redirect_to_inside_live_sessions(%Phoenix.LiveView.Socket{} = socket) do
    Phoenix.LiveView.push_redirect(socket, to: live_sessions())
  end

  defp live_sessions do
    Routes.inside_live_sessions_path(InterWeb.Endpoint, :index)
  end
end
