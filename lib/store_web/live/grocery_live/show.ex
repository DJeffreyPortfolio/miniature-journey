defmodule StoreWeb.GroceryLive.Show do
  use StoreWeb, :live_view

  alias Store.Products
  alias Store.Accounts

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
     |> assign(:grocery, Products.get_grocery!(id))
    }
  end

  defp assign_user(socket, token) do
    assign_new(socket, :current_user, fn -> 
      Accounts.get_user_by_session_token(token)
    end)
  end

end
