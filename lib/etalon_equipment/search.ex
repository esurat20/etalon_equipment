defmodule EtalonEquipment.Search do
  alias EtalonEquipment.Equipments.Equipment

  import Ecto.Query
  def search(query, _, %{category_id: nil}), do: query

  def search(query, Equipment, %{category_id: category_id}) do
    if String.trim(category_id) == "" do
      query
    else
      from(e in query, left_join: c in assoc(e, :category), where: c.id == ^category_id)
    end
  end

  def search(query, _, %{employee_id: nil}), do: query

  def search(query, Equipment, %{employee_id: employee_id}) do
    if String.trim(employee_id) == "" do
      query
    else
      from(e in query, left_join: em in assoc(e, :employee), where: em.id == ^employee_id)
    end
  end
end
