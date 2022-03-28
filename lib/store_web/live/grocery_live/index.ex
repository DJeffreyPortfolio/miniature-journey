defmodule StoreWeb.GroceryLive.Index do
  use StoreWeb, :live_view

  alias Store.Products
  alias Store.Products.Grocery
  alias Store.Accounts

  @impl true
  def mount(_params,  %{"user_token" => token } = _session, socket) do
    if connected?(socket), do: Products.subscribe()
    {:ok, 
      socket
      |> assign_user(token)
      |> assign(:groceries, list_groceries())
      |> assign(temporary_assigns: [groceries: []])
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Grocery")
    |> assign(:grocery, Products.get_grocery!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Grocery")
    |> assign(:grocery, %Grocery{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Groceries")
    |> assign(:grocery, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    grocery = Products.get_grocery!(id)
    {:ok, _} = Products.delete_grocery(grocery)

    {:noreply, assign(socket, :groceries, list_groceries())}
  end

  defp list_groceries do
    Products.list_groceries()
  end

  @impl true
  def handle_info({:grocery_created, grocery}, socket) do
    {:noreply, update(socket, :groceries, fn groceries -> [grocery | groceries] end)}
  end

  @impl true
  def handle_info({:grocery_updated, grocery}, socket) do
    {:noreply, update(socket, :groceries, fn groceries -> [grocery | groceries] end)}
  end

  defp assign_user(socket, token) do
    assign_new(socket, :current_user, fn -> 
      Accounts.get_user_by_session_token(token)
    end)
  end
end
