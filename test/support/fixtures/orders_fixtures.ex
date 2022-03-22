defmodule Store.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        product: "some product",
        quantity: 42,
        total: "120.5"
      })
      |> Store.Orders.create_order()

    order
  end
end
