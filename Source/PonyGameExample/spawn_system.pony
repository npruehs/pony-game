use "ponygame"

class SpawnSystem is GameSystem
  var _game: Game
  
  
  new create(game: Game) =>
    _game = game
    
    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("BlockGroundedEvent", this)
    true
  
  fun ref start(): Bool =>
    // Spawn initial block.
    _spawn_block()
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    true

  fun ref notify(event: GameEvent): None =>
    try
      _on_block_grounded(event as BlockGroundedEvent)
    end

  fun ref _on_block_grounded(event: BlockGroundedEvent): None =>
    // Spawn new block.
    _spawn_block()

  fun ref _spawn_block(): None =>
    // Create entity.
    let entity = _game.entity_manager().create_entity()

    // Add components.
    let image_component = ImageComponent("I.png")
    _game.entity_manager().add_component(entity, image_component)

    let position_component = PositionComponent(5, 0)
    _game.entity_manager().add_component(entity, position_component)

    let fall_component = FallComponent
    _game.entity_manager().add_component(entity, fall_component)
    
    // Notify listeners.
    let block_spawned_event = BlockSpawnedEvent(entity)
    _game.event_manager().push(block_spawned_event)