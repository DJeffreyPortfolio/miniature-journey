defmodule StoreWeb.PublicGroceryLive.Show do
    use StoreWeb, :live_view
  
    alias Store.Products
  
    @impl true
    def mount(_params, _session, socket) do
      {:ok, socket}
    end
  
    @impl true
    def handle_params(%{"id" => id}, _, socket) do
      {:noreply,
       socket
       |> assign(:page_title, page_title(socket.assigns.live_action))
       |> assign(:grocery, Products.get_grocery!(id))}
    end
  
    defp page_title(:show), do: "Show Grocery"
  end
  