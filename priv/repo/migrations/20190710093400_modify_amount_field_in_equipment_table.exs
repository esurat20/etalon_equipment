defmodule EtalonEquipment.Repo.Migrations.ModifyAmountFieldInEquipmentTable do
  use Ecto.Migration

  def change do
    alter table(:equipments) do
      modify(:amount, :decimal)
    end
  end
end
