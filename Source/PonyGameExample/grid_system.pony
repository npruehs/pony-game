use "ponygame"

class GridSystem is GameSystem
  let _width: I32 = 10
  let _height: I32 = 20

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
    let grid_component = GridComponent(_width.usize(), _height.usize())
    _game.entity_manager().add_component(_grid, grid_component)

    // Notify listeners.
    let grid_initialized_event = GridInitializedEvent(_width, _height)
    _game.event_manager().push(grid_initialized_event)

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

      // Check if reached grid bottom.
      if position_component.y == I32.from[USize](grid_component.height() - 1) then
        _ground_block(block)
      end

      // Check if hit another block.
      let x = USize.from[I32](position_component.x)
      let y = USize.from[I32](position_component.y)

      if grid_component.grid(x)(y + 1) != 0 then
        _ground_block(block)
      end
    end

  fun ref _ground_block(block: U64): None =>
    _game.logger().log("Block " + block.string() + " grounded.")

    // Update grid.
    try
      let position_component = _game.entity_manager().get_component[PositionComponent](block, "PositionComponent")
      let grid_component = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      let x = USize.from[I32](position_component.x)
      let y = USize.from[I32](position_component.y)

      grid_component.grid(x)(y) = 1

      _game.logger().log("Grid blocked at " + x.string() + "/" + y.string())
    end

    // Notify listeners.
    let block_grounded_event = BlockGroundedEvent(block)
    _game.event_manager().push(block_grounded_event)