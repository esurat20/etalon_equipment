defmodule EtalonEquipment.Repo.Migrations.AddCountTypeAndCostToEquipmentsTable do
  use Ecto.Migration

  def change do
    alter table(:equipments) do
      add(:count_type, :string)
      add(:cost, :string)
    end
  end
end
