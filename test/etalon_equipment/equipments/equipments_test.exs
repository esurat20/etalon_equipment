defmodule EtalonEquipment.EquipmentsTest do
  use EtalonEquipment.DataCase

  alias EtalonEquipment.Equipments

  describe "equipments" do
    alias EtalonEquipment.Equipments.Equipment

    @valid_attrs %{amount: 42, name: "some name"}
    @update_attrs %{amount: 43, name: "some updated name"}
    @invalid_attrs %{amount: nil, name: nil}

    def equipment_fixture(attrs \\ %{}) do
      {:ok, equipment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Equipments.create_equipment()

      equipment
    end

    test "list_equipments/0 returns all equipments" do
      equipment = equipment_fixture()
      assert Equipments.list_equipments() == [equipment]
    end

    test "get_equipment!/1 returns the equipment with given id" do
      equipment = equipment_fixture()
      assert Equipments.get_equipment!(equipment.id) == equipment
    end

    test "create_equipment/1 with valid data creates a equipment" do
      assert {:ok, %Equipment{} = equipment} = Equipments.create_equipment(@valid_attrs)
      assert equipment.amount == 42
      assert equipment.name == "some name"
    end

    test "create_equipment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Equipments.create_equipment(@invalid_attrs)
    end

    test "update_equipment/2 with valid data updates the equipment" do
      equipment = equipment_fixture()
      assert {:ok, equipment} = Equipments.update_equipment(equipment, @update_attrs)
      assert %Equipment{} = equipment
      assert equipment.amount == 43
      assert equipment.name == "some updated name"
    end

    test "update_equipment/2 with invalid data returns error changeset" do
      equipment = equipment_fixture()
      assert {:error, %Ecto.Changeset{}} = Equipments.update_equipment(equipment, @invalid_attrs)
      assert equipment == Equipments.get_equipment!(equipment.id)
    end

    test "delete_equipment/1 deletes the equipment" do
      equipment = equipment_fixture()
      assert {:ok, %Equipment{}} = Equipments.delete_equipment(equipment)
      assert_raise Ecto.NoResultsError, fn -> Equipments.get_equipment!(equipment.id) end
    end

    test "change_equipment/1 returns a equipment changeset" do
      equipment = equipment_fixture()
      assert %Ecto.Changeset{} = Equipments.change_equipment(equipment)
    end
  end
end
