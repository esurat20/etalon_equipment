defmodule EtalonEquipmentWeb.EquipmentController do
  use EtalonEquipmentWeb, :controller

  alias EtalonEquipment.{Repo, Equipments, Employees, Categories}
  alias EtalonEquipment.Equipments.Equipment

  def index(conn, params) do
    equipments =
      Equipment
      |> EtalonEquipment.Search.search(Equipment, %{category_id: params["search"]["category"]})
      |> EtalonEquipment.Search.search(Equipment, %{employee_id: params["search"]["employee"]})
      |> Repo.all()
      |> Repo.preload([:category, :employee])

    employees = Employees.list_employees()
    categories = Categories.list_categories()

    render(conn, "index.html",
      equipments: equipments,
      categories: categories,
      employees: employees
    )
  end

  def new(conn, _params) do
    changeset = Equipments.change_equipment(%Equipment{})
    categories = Categories.list_categories()
    employees = Employees.list_employees()
    render(conn, "new.html", changeset: changeset, categories: categories, employees: employees)
  end

  def create(conn, %{"equipment" => equipment_params}) do
    categories = Categories.list_categories()
    employees = Employees.list_employees()

    case Equipments.create_equipment(equipment_params) do
      {:ok, equipment} ->
        conn
        |> put_flash(:info, "Оборудование успешно создано.")
        |> redirect(to: equipment_path(conn, :show, equipment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          categories: categories,
          employees: employees
        )
    end
  end

  def show(conn, %{"id" => id}) do
    equipment =
      Equipments.get_equipment!(id)
      |> Repo.preload([:category, :employee])

    render(conn, "show.html", equipment: equipment)
  end

  def edit(conn, %{"id" => id}) do
    equipment = Equipments.get_equipment!(id)
    changeset = Equipments.change_equipment(equipment)
    categories = Categories.list_categories()
    employees = Employees.list_employees()

    render(conn, "edit.html",
      equipment: equipment,
      changeset: changeset,
      categories: categories,
      employees: employees
    )
  end

  def update(conn, %{"id" => id, "equipment" => equipment_params}) do
    equipment = Equipments.get_equipment!(id)

    case Equipments.update_equipment(equipment, equipment_params) do
      {:ok, equipment} ->
        conn
        |> put_flash(:info, "Оборудование успешно обновлено.")
        |> redirect(to: equipment_path(conn, :show, equipment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", equipment: equipment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    equipment = Equipments.get_equipment!(id)
    {:ok, _equipment} = Equipments.delete_equipment(equipment)

    conn
    |> put_flash(:info, "Оборудование удалено.")
    |> redirect(to: equipment_path(conn, :index))
  end
end
