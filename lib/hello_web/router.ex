defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug HelloWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    resources "/users", UsersController, only: [:index, :show, :new, :create]

#get "/users", UsersController, :index
#get "/users/:id/edit", UsersController, :edit
#get "/users/new", UsersController, :new
#get "/users/:id", UsersController, :show
#post "/users", UsersController, :create
#patch "/users/:id", UsersController, :update
#put "/users/:id", UsersController, :update
#delete "/users/:id", UsersController, :delete

    get "/users_test/:id", UsersController, :show
    get "/users_test/", UsersController, :index

    get "/hello/:name", HelloController, :world2
    get "/hello", HelloController, :world

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/videos", VideoController

    get "/watch/:id", WatchController, :show

    get "/", PageController, :index
  end

  scope "/manage", HelloWeb do
    pipe_through [:browser, :authenticate_user]
    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
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
      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
    end
  end
end
