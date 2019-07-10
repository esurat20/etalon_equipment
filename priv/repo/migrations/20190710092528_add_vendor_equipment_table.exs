defmodule EtalonEquipment.Repo.Migrations.AddVendorEquipmentTable do
  use Ecto.Migration

  def change do
    alter table(:equipments) do
      add(:vendor, :string)
    end
  end
end
