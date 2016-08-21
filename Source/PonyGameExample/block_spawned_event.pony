use "ponygame"

class BlockSpawnedEvent is GameEvent
  var entity: U64
  

  new create(entity': U64) =>
    entity = entity'

  fun event_type(): String =>
    "BlockSpawnedEvent"
