defmodule Store.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Products` context.
  """

  @doc """
  Generate a grocery.
  """
  def grocery_fixture(attrs \\ %{}) do
    {:ok, grocery} =
      attrs
      |> Enum.into(%{
        image: "some image",
        name: "some name",
        price: "120.5",
        quantity: 42
      })
      |> Store.Products.create_grocery()

    grocery
  end
end
