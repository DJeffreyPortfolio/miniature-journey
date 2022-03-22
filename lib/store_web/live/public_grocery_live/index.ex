defmodule StoreWeb.PublicGroceryLive.Index do
    use StoreWeb, :live_view
  
    alias Store.Products
    alias Store.Products.Grocery
  
    @impl true
    def mount(_params, _session, socket) do
      {:ok, assign(socket, :groceries, list_groceries())}
    end
  
    @impl true
    defp apply_action(socket, :index, _params) do
      socket
      |> assign(:page_title, "Listing Groceries")
      |> assign(:grocery, nil)
    end
  
    defp list_groceries do
      Products.list_groceries()
    end
  end
  