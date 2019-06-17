defmodule EtalonEquipment.Equipments.Equipment do
  use Ecto.Schema
  import Ecto.Changeset

  alias EtalonEquipment.Employees.Employee
  alias EtalonEquipment.Categories.Category

  schema "equipments" do
    field(:amount, :integer)
    field(:name, :string)
    field(:count_type, :string)
    field(:cost, :string)
    belongs_to(:employee, Employee)
    belongs_to(:category, Category)

    timestamps()
  end

  @doc false
  def changeset(equipment, attrs) do
    equipment
    |> cast(attrs, [:name, :amount, :count_type, :cost, :employee_id, :category_id])
    |> validate_required([:name, :amount, :count_type, :cost, :employee_id, :category_id])
  end
end
