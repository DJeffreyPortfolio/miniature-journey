defmodule Store.Repo.Migrations.CreateGroceries do
  use Ecto.Migration

  def change do
    create table(:groceries) do
      add :name, :string
      add :quantity, :integer
      add :price, :decimal
      add :image, :string

      timestamps()
    end
  end
end
