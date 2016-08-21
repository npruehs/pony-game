use "ponygame"

class PositionChangedEvent is GameEvent
  var entity: U64
  var old_x: I32
  var old_y: I32
  var new_x: I32
  var new_y: I32

  new create(entity': U64, old_x': I32, old_y': I32, new_x': I32, new_y': I32) =>
    entity = entity'
    old_x = old_x'
    old_y = old_y'
    new_x = new_x'
    new_y = new_y'

  fun event_type(): String =>
    "PositionChangedEvent"
