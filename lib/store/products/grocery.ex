defmodule Store.Products.Grocery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groceries" do
    field :image, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(grocery, attrs) do
    grocery
    |> cast(attrs, [:name, :quantity, :price])
    |> validate_required([:name, :quantity, :price])
  end

end
