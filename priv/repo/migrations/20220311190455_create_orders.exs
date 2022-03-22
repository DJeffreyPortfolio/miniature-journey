defmodule Store.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :product, :string
      add :quantity, :integer
      add :total, :decimal
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:orders, [:user_id])
  end
end
