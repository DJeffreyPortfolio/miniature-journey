defmodule Store.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Store.Repo

  alias Store.Products.Grocery

  @doc """
  Returns the list of groceries.

  ## Examples

      iex> list_groceries()
      [%Grocery{}, ...]

  """
  def list_groceries do
    Repo.all(Grocery)
  end

  @doc """
  Gets a single grocery.

  Raises `Ecto.NoResultsError` if the Grocery does not exist.

  ## Examples

      iex> get_grocery!(123)
      %Grocery{}

      iex> get_grocery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grocery!(id), do: Repo.get!(Grocery, id)

  @doc """
  Creates a grocery.

  ## Examples

      iex> create_grocery(%{field: value})
      {:ok, %Grocery{}}

      iex> create_grocery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grocery(attrs \\ %{}) do   
    %Grocery{}
    |> Grocery.changeset(attrs)
    |> Ecto.Changeset.put_change(:image, image_select(attrs))
    |> Repo.insert()
  end

  # Image select from folder priv/images
  # if name doesn't match, it'll put last image.
  def image_select(attrs) do
    case attrs["name"] do
      "apple" -> title = "/images/apple.jpeg"
      "asparagus" -> title = "/images/asparagus.jpeg"
      "avocado" -> title = "/images/avocado.jpeg"
      "cabbage" -> title = "/images/cabbage.jpeg"
      "mango" -> title = "/images/mango.jpeg"
      "orange" -> title = "/images/orange.jpeg"
      "potato" -> title = "/images/potato.jpeg"
      _ -> title = "/images/shrug.jpeg"
    end 
  end

  @doc """
  Updates a grocery.

  ## Examples

      iex> update_grocery(grocery, %{field: new_value})
      {:ok, %Grocery{}}

      iex> update_grocery(grocery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grocery(%Grocery{} = grocery, attrs) do
    grocery
    |> Grocery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a grocery.

  ## Examples

      iex> delete_grocery(grocery)
      {:ok, %Grocery{}}

      iex> delete_grocery(grocery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grocery(%Grocery{} = grocery) do
    Repo.delete(grocery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grocery changes.

  ## Examples

      iex> change_grocery(grocery)
      %Ecto.Changeset{data: %Grocery{}}

  """
  def change_grocery(%Grocery{} = grocery, attrs \\ %{}) do
    Grocery.changeset(grocery, attrs)
  end
end
