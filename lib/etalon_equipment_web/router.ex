defmodule EtalonEquipmentWeb.Router do
  use EtalonEquipmentWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", EtalonEquipmentWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/employees", EmployeeController)
    resources("/categories", CategoryController)
    resources("/equipments", EquipmentController)
  end

  scope "/exports", as: :exports, alias: EtalonEquipmentWeb.Exports do
    pipe_through(:browser)
    resources("/equipments", EquipmentController, only: [:index])
  end

  # Other scopes may use custom stacks.
  # scope "/api", EtalonEquipmentWeb do
  #   pipe_through :api
  # end
end
