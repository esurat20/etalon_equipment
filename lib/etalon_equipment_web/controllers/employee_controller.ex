defmodule EtalonEquipmentWeb.EmployeeController do
  use EtalonEquipmentWeb, :controller

  alias EtalonEquipment.Employees
  alias EtalonEquipment.Employees.Employee

  def index(conn, _params) do
    employees = Employees.list_employees()
    render(conn, "index.html", employees: employees)
  end

  def new(conn, _params) do
    changeset = Employees.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Employees.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Работник успешно создан.")
        |> redirect(to: employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Employees.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end

  def edit(conn, %{"id" => id}) do
    employee = Employees.get_employee!(id)
    changeset = Employees.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Employees.get_employee!(id)

    case Employees.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Работник успешно обновлен.")
        |> redirect(to: employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Employees.get_employee!(id)
    {:ok, _employee} = Employees.delete_employee(employee)

    conn
    |> put_flash(:info, "Работник успешно удален.")
    |> redirect(to: employee_path(conn, :index))
  end
end
