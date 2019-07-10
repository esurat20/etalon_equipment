defmodule EtalonEquipmentWeb.Exports.EquipmentController do
  use EtalonEquipmentWeb, :controller

  alias EtalonEquipment.{Repo, Equipments.Equipment}

  def index(conn, params) do
    equipments =
      Equipment
      |> EtalonEquipment.Search.search(Equipment, %{category_id: params["search"]["category"]})
      |> EtalonEquipment.Search.search(Equipment, %{employee_id: params["search"]["employee"]})
      |> Repo.all()
      |> Repo.preload([:category, :employee])

    conn
    |> put_resp_content_type("text/xlsx")
    |> put_resp_header("content-disposition", "attachment; filename=posts_report.xlsx")
    |> render("report.xlsx", %{equipments: equipments})
  end
end
