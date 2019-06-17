defmodule EtalonEquipmentWeb.PageController do
  use EtalonEquipmentWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
