defmodule StoreWeb.GroceryLiveTest do
  use StoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import Store.ProductsFixtures

  @create_attrs %{image: "some image", name: "some name", price: "120.5", quantity: 42}
  @update_attrs %{image: "some updated image", name: "some updated name", price: "456.7", quantity: 43}
  @invalid_attrs %{image: nil, name: nil, price: nil, quantity: nil}

  defp create_grocery(_) do
    grocery = grocery_fixture()
    %{grocery: grocery}
  end

  describe "Index" do
    setup [:create_grocery]

    test "lists all groceries", %{conn: conn, grocery: grocery} do
      {:ok, _index_live, html} = live(conn, Routes.grocery_index_path(conn, :index))

      assert html =~ "Listing Groceries"
      assert html =~ grocery.image
    end

    test "saves new grocery", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.grocery_index_path(conn, :index))

      assert index_live |> element("a", "New Grocery") |> render_click() =~
               "New Grocery"

      assert_patch(index_live, Routes.grocery_index_path(conn, :new))

      assert index_live
             |> form("#grocery-form", grocery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#grocery-form", grocery: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grocery_index_path(conn, :index))

      assert html =~ "Grocery created successfully"
      assert html =~ "some image"
    end

    test "updates grocery in listing", %{conn: conn, grocery: grocery} do
      {:ok, index_live, _html} = live(conn, Routes.grocery_index_path(conn, :index))

      assert index_live |> element("#grocery-#{grocery.id} a", "Edit") |> render_click() =~
               "Edit Grocery"

      assert_patch(index_live, Routes.grocery_index_path(conn, :edit, grocery))

      assert index_live
             |> form("#grocery-form", grocery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#grocery-form", grocery: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grocery_index_path(conn, :index))

      assert html =~ "Grocery updated successfully"
      assert html =~ "some updated image"
    end

    test "deletes grocery in listing", %{conn: conn, grocery: grocery} do
      {:ok, index_live, _html} = live(conn, Routes.grocery_index_path(conn, :index))

      assert index_live |> element("#grocery-#{grocery.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#grocery-#{grocery.id}")
    end
  end

  describe "Show" do
    setup [:create_grocery]

    test "displays grocery", %{conn: conn, grocery: grocery} do
      {:ok, _show_live, html} = live(conn, Routes.grocery_show_path(conn, :show, grocery))

      assert html =~ "Show Grocery"
      assert html =~ grocery.image
    end

    test "updates grocery within modal", %{conn: conn, grocery: grocery} do
      {:ok, show_live, _html} = live(conn, Routes.grocery_show_path(conn, :show, grocery))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Grocery"

      assert_patch(show_live, Routes.grocery_show_path(conn, :edit, grocery))

      assert show_live
             |> form("#grocery-form", grocery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#grocery-form", grocery: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grocery_show_path(conn, :show, grocery))

      assert html =~ "Grocery updated successfully"
      assert html =~ "some updated image"
    end
  end
end
