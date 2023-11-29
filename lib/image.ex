defmodule Identicon.Image do
  @doc """ 

  Stores the data for our application. 
  Nota Bene: This is not a "class"
  It can only hold primitive data (no funcs ...)

  It is like a map with default properties 
  and "determined" keys. (ie it can be assigned new keys)

  """
  defstruct hex: nil, color: nil
end

