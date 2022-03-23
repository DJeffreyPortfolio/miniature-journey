defmodule StoreWeb.GroceryLive.OrderComponent do
    use StoreWeb, :live_component
  
    alias Store.Orders
    alias Store.Orders.Order

    @impl true
    def update(assigns, socket) do
      {:ok,
       socket
       |> assign(:current_user, assigns[:current_user].id)
       |> assign(:name, assigns[:grocery].name)
       |> assign(:amount, assigns[:grocery].quantity)
       |> assign(:price, assigns[:grocery].price)
       |> assign(:total_price, assigns[:grocery].price)
       |> assign(:changeset, Orders.change_order(%Order{}))
      }
    end
  
    @impl true
    def handle_event("total", %{"order" => order_params}, socket) do      
        {:noreply,
          socket
          |> assign(:total_price, gather_total_price(order_params["quantity"], socket.assigns.price))
        }
    end
  
    def handle_event("save", %{"order" => order_params}, socket) do
        case Orders.create_order(order_params) do
            {:ok, _order} ->
                {:noreply,
                socket
                |> put_flash(:info, "Order created successfully")
            }

            {:error, %Ecto.Changeset{} = changeset} ->
                {:noreply, assign(socket, changeset: changeset)}
        end
    end

    def gather_total_price(quantity, price) do
      quantity_to_decimal = Decimal.cast(quantity)

      #Using elem here because Decimal.cast returns a tuple {:ok, Decimal}.
      total_price = Decimal.mult(elem(quantity_to_decimal, 1), price)
    end
  
  end
  