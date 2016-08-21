use "ponygame"

class GridInitializedEvent is GameEvent
  var entity: U64
  var width: I32
  var height: I32
  
  new create(entity': U64, width': I32, height': I32) =>
    entity = entity'
    width = width'
    height = height'

  fun event_type(): String =>
    "GridInitializedEvent"
