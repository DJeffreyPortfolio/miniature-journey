defmodule Store.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Store.Accounts.User

  schema "orders" do
    field :product, :string
    field :quantity, :integer
    field :total, :decimal
    belongs_to :user, User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:product, :quantity, :total, :user_id])
    |> validate_required([:product, :quantity, :total, :user_id])
  end
end
