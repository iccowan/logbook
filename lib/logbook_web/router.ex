defmodule LogbookWeb.Router do
  use LogbookWeb, :router

  @host :logbook
        |> Application.compile_env!(LogbookWeb.Endpoint)
        |> Keyword.fetch!(:url)
        |> Keyword.fetch!(:host)

  @content_security_policy (case Mix.env() do
                              :prod ->
                                "default-src 'self' 'unsafe-eval'" <>
                                  "connect-src wss://#{@host};" <>
                                  "img-src 'self' https://*.unsplash.com/ blob:;" <>
                                  "font-src data:;"

                              _ ->
                                "default-src 'self' 'unsafe-eval' 'unsafe-inline';" <>
                                  "connect-src ws://#{@host}:*;" <>
                                  "img-src 'self' https://*.unsplash.com/ blob: data:;" <>
                                  "font-src data:;"
                            end)

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery

    plug :put_secure_browser_headers, %{
      "content-security-policy" => @content_security_policy
    }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LogbookWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LogbookWeb do
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
      live_dashboard "/dashboard", metrics: LogbookWeb.Telemetry
    end
  end
end
