defmodule EtalonEquipmentWeb.Exports.EquipmentView do
  use EtalonEquipmentWeb, :view

  alias Elixlsx.{Workbook, Sheet}

  @header [
    "Наименование",
    "Количество",
    "Единица измерения",
    "Стоимость",
    "Работник",
    "Категория",
    "Поставщик"
  ]

  def render("report.xlsx", %{equipments: equipments}) do
    report_generator(equipments)
    |> Elixlsx.write_to_memory("report.xlsx")
    |> elem(1)
    |> elem(1)
  end

  def report_generator(equipments) do
    rows = equipments |> Enum.map(&row(&1))
    %Workbook{sheets: [%Sheet{name: "Equipments", rows: [@header] ++ rows}]}
  end

  def row(equipment) do
    [
      equipment.name,
      to_string(equipment.amount),
      equipment.count_type,
      equipment.cost,
      equipment.employee.name,
      equipment.category.name,
      equipment.vendor
    ]
  end
end
