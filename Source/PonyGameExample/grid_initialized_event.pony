use "ponygame"

class GridInitializedEvent is GameEvent
  var width: I32
  var height: I32
  

  new create(width': I32, height': I32) =>
    width = width'
    height = height'

  fun event_type(): String =>
    "GridInitializedEvent"
