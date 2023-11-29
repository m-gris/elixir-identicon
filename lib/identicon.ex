defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input
  end
  
  @doc """
  
  ## Examples 

    iex> Map.get(Identicon.hash_input("Elixir"), :hex)
    [161, 46, 176, 98, 236, 169, 209, 230, 198, 159, 207, 139, 96, 55, 135, 195]
    

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end




  
  @doc """ 
  
  ## Examples 

    iex> hash = Identicon.hash_input("Elixir")
    iex> Map.get(Identicon.get_color(hash), :color)
    {161, 46, 176}

  """
  def get_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail] } = image
    %Identicon.Image{image | color: {r, g, b}}
  end


  

  @doc """ 
  
  ## Examples 
    
    iex> Identicon.mirror([1, 2, 3, 4])
    [1, 2, 3, 4, 3, 2, 1]


  """ 
  def mirror(list) do
    end_of_slice = Enum.count(list) - 2
    to_be_mirrored = Enum.slice(list, 0..end_of_slice)
    new_tail = Enum.reverse(to_be_mirrored)
    Enum.concat(list, new_tail)
  end

end
