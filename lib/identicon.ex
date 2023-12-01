defmodule Identicon do
  @moduledoc """
  A module that will generate a random Identicon from an input string.
  """

  def main(input) do
    input
    |> hash_input
    |> get_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
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
    %Identicon.Image{ image | color: {r, g, b}}
  end



  
  def build_grid(image) do 
    %Identicon.Image{hex: hex} = image
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&Identicon.mirror/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{ image | grid: grid}
  end
  


  def filter_odd_squares(image) do 

    # "PULL OUT" THE GRID FROM THE IMAGE
    %Identicon.Image{grid: grid} = image

    # TRANSFORM THE GRID
    filtered_grid = Enum.filter(grid, fn({num, _idx}) -> 
          rem(num, 2) == 0 
        end)
    
    # RETURN AN IMAGE WITH THE NEW GRID
    %Identicon.Image{image | grid: filtered_grid}

  end


  @doc """ 
  
  ## Examples 
    
    iex> Identicon.mirror([1, 2, 3, 4])
    [1, 2, 3, 4, 3, 2, 1]


  """ 
  def mirror(list) do
    new_tail = Enum.reverse(list) |> Enum.drop(1)
    list ++ new_tail
  end
  

  def build_pixel_image(image) do  
    %Identicon.Image{grid: grid} = image
    pixel_map = Enum.map(grid, fn({_value, idx}) -> 
        upper_left_x = rem(idx, 5) * 50
        upper_left_y = div(idx, 5) * 50 
        lower_right_x = upper_left_x + 50
        lower_right_y = upper_left_y + 50 
        {{upper_left_x, upper_left_y}, {lower_right_x, lower_right_y}} 
      end)
    %Identicon.Image{image | pixel_map: pixel_map}
  end
end
