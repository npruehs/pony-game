use "ponygame"

class PositionComponent is EntityComponent
  var x: I32
  var y: I32
  
  new create(x': I32, y': I32) =>
    x = x'
    y = y'
    
    
  fun component_type(): String =>
    "PositionComponent"