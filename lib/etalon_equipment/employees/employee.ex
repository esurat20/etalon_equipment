defmodule EtalonEquipment.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset


  schema "employees" do
    field :name, :string
    field :position, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :position])
    |> validate_required([:name, :position])
  end
end
