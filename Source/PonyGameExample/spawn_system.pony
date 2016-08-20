use "ponygame"

class SpawnSystem is GameSystem
  var _game: Game
  
  
  new create(game: Game) =>
    _game = game
    
    
  fun ref init(): Bool =>
    true
  
  fun ref start(): Bool =>
    // Spawn initial block.
    _spawn_block()
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    true

  fun ref _spawn_block(): None =>
    // Create entity.
    let entity = _game.entity_manager().create_entity()

    // Add components.
    let image_component = ImageComponent("I.png")
    _game.entity_manager().add_component(entity, image_component)

    let position_component = PositionComponent(5, 0)
    _game.entity_manager().add_component(entity, position_component)

    // Notify listeners.
    let block_spawned_event = BlockSpawnedEvent(entity)
    _game.event_manager().push(block_spawned_event)