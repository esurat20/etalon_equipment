defmodule EtalonEquipmentWeb.EquipmentView do
  use EtalonEquipmentWeb, :view

  def entities_for_select(entities) do
    entities
    |> Enum.map(&{&1.name, &1.id})
  end
end
