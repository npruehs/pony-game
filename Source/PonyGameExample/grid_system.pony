use "ponygame"

class GridSystem is GameSystem
  var _game: Game
  
  var _grid: U64
  
  new create(game: Game) =>
    _game = game
    _grid = 0

    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("PositionChangedEvent", this)
    true
  
  fun ref start(): Bool =>
    // Create grid entity.
    _grid = _game.entity_manager().create_entity()

    // Add components.
    let grid_component = GridComponent(10, 20)
    _game.entity_manager().add_component(_grid, grid_component)

    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    true

  fun ref notify(event: GameEvent): None =>
    try
      _on_position_changed(event as PositionChangedEvent)
    end

  fun ref _on_position_changed(event: PositionChangedEvent): None =>
    // Check if grounded.
    let block = event.entity
    
    _game.logger().log("Block " + block.string() + " position changed.")

    try
      let position_component = _game.entity_manager().get_component[PositionComponent](block, "PositionComponent")
      let grid_component = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      if position_component.y >= I32.from[USize](grid_component.height()) then
        _game.logger().log("Block " + block.string() + " grounded.")

        // Notify listeners.
        let block_grounded_event = BlockGroundedEvent(block)
        _game.event_manager().push(block_grounded_event)
      end
    end