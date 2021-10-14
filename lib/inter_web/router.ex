defmodule InterWeb.Router do
  use InterWeb, :router

  import InterWeb.Navigation,
    only: [
      assign_current_path: 2,
      redirect_if_was_inside: 2
    ]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {InterWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_path
    plug PhoenixWeb.LiveProfiler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :inside,
    on_mount: [{InterWeb.Navigation, :assign_current_path}],
    session: %{"inside" => true} do
    scope "/", InterWeb do
      pipe_through :browser

      get "/", PageController, :index
      live "/inside", InsideLive, :index
      live "/inside/mount", InsideLive.Mount, :index
      live "/inside/navigation", InsideLive.Navigation, :index
      live "/inside/navigation/color/:colour", InsideLive.Navigation, :color
      live "/inside/events", InsideLive.Events, :index
      live "/inside/events/color/:red/:green/:blue", InsideLive.Events, :color
      live "/inside/messages", InsideLive.Messages, :index
      live "/inside/sessions", InsideLive.LiveSessions, :index
      live "/inside/lifecycle-hooks", InsideLive.LifecycleHooks, :index
    end
  end

  live_session :outside,
    on_mount: [{InterWeb.Navigation, :redirect_if_was_inside}],
    session: %{"outside" => true} do
    scope "/", InterWeb do
      pipe_through [:browser, :redirect_if_was_inside]
      live "/outside", OutsideLive, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", InterWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: InterWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
