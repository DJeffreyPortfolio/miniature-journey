defmodule Store.ProductsTest do
  use Store.DataCase

  alias Store.Products

  describe "groceries" do
    alias Store.Products.Grocery

    import Store.ProductsFixtures

    @invalid_attrs %{image: nil, name: nil, price: nil, quantity: nil}

    test "list_groceries/0 returns all groceries" do
      grocery = grocery_fixture()
      assert Products.list_groceries() == [grocery]
    end

    test "get_grocery!/1 returns the grocery with given id" do
      grocery = grocery_fixture()
      assert Products.get_grocery!(grocery.id) == grocery
    end

    test "create_grocery/1 with valid data creates a grocery" do
      valid_attrs = %{image: "some image", name: "some name", price: "120.5", quantity: 42}

      assert {:ok, %Grocery{} = grocery} = Products.create_grocery(valid_attrs)
      assert grocery.image == "some image"
      assert grocery.name == "some name"
      assert grocery.price == Decimal.new("120.5")
      assert grocery.quantity == 42
    end

    test "create_grocery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_grocery(@invalid_attrs)
    end

    test "update_grocery/2 with valid data updates the grocery" do
      grocery = grocery_fixture()
      update_attrs = %{image: "some updated image", name: "some updated name", price: "456.7", quantity: 43}

      assert {:ok, %Grocery{} = grocery} = Products.update_grocery(grocery, update_attrs)
      assert grocery.image == "some updated image"
      assert grocery.name == "some updated name"
      assert grocery.price == Decimal.new("456.7")
      assert grocery.quantity == 43
    end

    test "update_grocery/2 with invalid data returns error changeset" do
      grocery = grocery_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_grocery(grocery, @invalid_attrs)
      assert grocery == Products.get_grocery!(grocery.id)
    end

    test "delete_grocery/1 deletes the grocery" do
      grocery = grocery_fixture()
      assert {:ok, %Grocery{}} = Products.delete_grocery(grocery)
      assert_raise Ecto.NoResultsError, fn -> Products.get_grocery!(grocery.id) end
    end

    test "change_grocery/1 returns a grocery changeset" do
      grocery = grocery_fixture()
      assert %Ecto.Changeset{} = Products.change_grocery(grocery)
    end
  end
end
