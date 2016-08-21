use "random"
use "time"

use "ponygame"

class SpawnSystem is GameSystem
  let _random: MT

  var _game: Game
  
  
  new create(game: Game) =>
    _game = game

    let time = Time
    let seed = time.wall_to_nanos(time.now())
    _random = MT(seed)
    
    
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
    let block_id = _random.next() % 2

    let position_component = PositionComponent(5, 0)
    _game.entity_manager().add_component(entity, position_component)

    let fall_component = FallComponent
    _game.entity_manager().add_component(entity, fall_component)

    if block_id == 0 then
      // I
      let image_component = ImageComponent("Teal.png")
      _game.entity_manager().add_component(entity, image_component)

      let grid_component = GridComponent(4, 1)
      try
        grid_component.grid(0)(0) = 1
        grid_component.grid(1)(0) = 1
        grid_component.grid(2)(0) = 1
        grid_component.grid(3)(0) = 1
      end
      _game.entity_manager().add_component(entity, grid_component)
    else
      // O
      let image_component = ImageComponent("Yellow.png")
      _game.entity_manager().add_component(entity, image_component)

      let grid_component = GridComponent(2, 2)
      try
        grid_component.grid(0)(0) = 1
        grid_component.grid(1)(0) = 1
        grid_component.grid(0)(1) = 1
        grid_component.grid(1)(1) = 1
      end
      _game.entity_manager().add_component(entity, grid_component)
    end

    // Notify listeners.
    let block_spawned_event = BlockSpawnedEvent(entity)
    _game.event_manager().push(block_spawned_event)

    _game.logger().log("Block type " + block_id.string() + " spawned.")