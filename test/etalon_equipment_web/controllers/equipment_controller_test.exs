defmodule EtalonEquipmentWeb.EquipmentControllerTest do
  use EtalonEquipmentWeb.ConnCase

  alias EtalonEquipment.Equipments

  @create_attrs %{amount: 42, name: "some name"}
  @update_attrs %{amount: 43, name: "some updated name"}
  @invalid_attrs %{amount: nil, name: nil}

  def fixture(:equipment) do
    {:ok, equipment} = Equipments.create_equipment(@create_attrs)
    equipment
  end

  describe "index" do
    test "lists all equipments", %{conn: conn} do
      conn = get conn, equipment_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Equipments"
    end
  end

  describe "new equipment" do
    test "renders form", %{conn: conn} do
      conn = get conn, equipment_path(conn, :new)
      assert html_response(conn, 200) =~ "New Equipment"
    end
  end

  describe "create equipment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, equipment_path(conn, :create), equipment: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == equipment_path(conn, :show, id)

      conn = get conn, equipment_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Equipment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, equipment_path(conn, :create), equipment: @invalid_attrs
      assert html_response(conn, 200) =~ "New Equipment"
    end
  end

  describe "edit equipment" do
    setup [:create_equipment]

    test "renders form for editing chosen equipment", %{conn: conn, equipment: equipment} do
      conn = get conn, equipment_path(conn, :edit, equipment)
      assert html_response(conn, 200) =~ "Edit Equipment"
    end
  end

  describe "update equipment" do
    setup [:create_equipment]

    test "redirects when data is valid", %{conn: conn, equipment: equipment} do
      conn = put conn, equipment_path(conn, :update, equipment), equipment: @update_attrs
      assert redirected_to(conn) == equipment_path(conn, :show, equipment)

      conn = get conn, equipment_path(conn, :show, equipment)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, equipment: equipment} do
      conn = put conn, equipment_path(conn, :update, equipment), equipment: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Equipment"
    end
  end

  describe "delete equipment" do
    setup [:create_equipment]

    test "deletes chosen equipment", %{conn: conn, equipment: equipment} do
      conn = delete conn, equipment_path(conn, :delete, equipment)
      assert redirected_to(conn) == equipment_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, equipment_path(conn, :show, equipment)
      end
    end
  end

  defp create_equipment(_) do
    equipment = fixture(:equipment)
    {:ok, equipment: equipment}
  end
end
