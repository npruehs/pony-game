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
    
    for x in Range[USize](0, _width) do
      var col = Array[I32](_height)

      for y in Range[USize](0, _height) do
        col = col.push(0)
      end

      grid = grid.push(col)
    end
    

  fun width(): USize =>
    _width
  
  fun height(): USize =>
    _height
    
  fun component_type(): String =>
    "GridComponent"