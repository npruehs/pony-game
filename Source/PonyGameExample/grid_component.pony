use "collections"

use "ponygame"

class GridComponent is EntityComponent
  let _width: USize
  let _height: USize

  var grid: Array[Array[I32]]
  
  
  new create(width': USize, height': USize) =>
    _width = width'
    _height = height'

    grid = Array[Array[I32]](_width)
    
    try
      for x in Range[USize](1, _width) do
        grid(x) = Array[I32](_height)
      end
    end
    
  fun width(): USize =>
    _width
  
  fun height(): USize =>
    _height
    
  fun component_type(): String =>
    "GridComponent"