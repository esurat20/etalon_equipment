defmodule EtalonEquipment.Repo.Migrations.CreateEquipments do
  use Ecto.Migration

  def change do
    create table(:equipments) do
      add :name, :string
      add :amount, :integer
      add :employee_id, references(:employees, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:equipments, [:employee_id])
    create index(:equipments, [:category_id])
  end
end
