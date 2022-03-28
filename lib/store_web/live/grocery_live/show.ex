defmodule StoreWeb.GroceryLive.Show do
  use StoreWeb, :live_view

  alias Store.Products
  alias Store.Accounts
  alias Store.Orders

  @impl true
  def mount(_params, %{"user_token" => token } = _session, socket) do
    {:ok, 
      socket
      |> assign_user(token)
    }
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Edit Grocery")
     |> assign(:grocery, Products.get_grocery!(id))
     |> assign(:orders, Orders.list_orders(socket.assigns.current_user))
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order = Orders.get_order!(id)
    {:ok, _} = Orders.delete_order(order)

    {:noreply, assign(socket, :orders, Orders.list_orders(socket))}
  end

  def handle_info({:update_order, order}, socket) do
    {:noreply, 
      socket
      |> assign(:orders, Orders.list_orders(socket))
    }
  end

  defp assign_user(socket, token) do
    assign_new(socket, :current_user, fn -> 
      Accounts.get_user_by_session_token(token)
    end)
  end

end
