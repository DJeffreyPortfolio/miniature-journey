defmodule StoreWeb.GroceryLive.FormComponent do
  use StoreWeb, :live_component

  alias Store.Products

  @impl true
  def update(%{grocery: grocery} = assigns, socket) do
    changeset = Products.change_grocery(grocery)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"grocery" => grocery_params}, socket) do
    changeset =
      socket.assigns.grocery
      |> Products.change_grocery(grocery_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"grocery" => grocery_params}, socket) do
    save_grocery(socket, socket.assigns.action, grocery_params)
  end

  defp save_grocery(socket, :edit, grocery_params) do
    case Products.update_grocery(socket.assigns.grocery, grocery_params) do
      {:ok, _grocery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Grocery updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_grocery(socket, :new, grocery_params) do
    case Products.create_grocery(grocery_params) do
      {:ok, _grocery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Grocery created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
