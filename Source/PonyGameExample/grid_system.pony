use "collections"

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
      let block_position_component = _game.entity_manager().get_component[PositionComponent](block, "PositionComponent")
      let block_grid_component = _game.entity_manager().get_component[GridComponent](block, "GridComponent")
      let game_grid_component = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      var grounded: Bool = false

      // Check if reached grid bottom.
      if (block_grid_component.height().i32() + block_position_component.y) == _height then
        grounded = true
      end

      // Check if hit another block.
      for x in Range[USize](0, block_grid_component.width()) do
        if block_grid_component.grid(x)(0) > 0 then
          let grid_x = x + block_position_component.x.usize()
          let grid_y = block_grid_component.height() + block_position_component.y.usize()

          try
            if game_grid_component.grid(grid_x)(grid_y) != 0 then
              grounded = true
            end
          end 
        end
      end

      if grounded then 
        _ground_block(block)
      end
    end

  fun ref _ground_block(block: U64): None =>
    _game.logger().log("Block " + block.string() + " grounded.")

    // Update grid.
    try
      let block_position_component = _game.entity_manager().get_component[PositionComponent](block, "PositionComponent")
      let block_grid_component = _game.entity_manager().get_component[GridComponent](block, "GridComponent")
      let game_grid_component = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      for x in Range[USize](0, block_grid_component.width()) do
        for y in Range[USize](0, block_grid_component.height()) do
          if block_grid_component.grid(x)(y) > 0 then
            let grid_x = x + block_position_component.x.usize()
            let grid_y = y + block_position_component.y.usize()

            game_grid_component.grid(grid_x)(grid_y) = 1

            _game.logger().log("Grid blocked at " + grid_x.string() + "/" + grid_y.string())
          end
        end
      end
    end

    // Notify listeners.
    let block_grounded_event = BlockGroundedEvent(block)
    _game.event_manager().push(block_grounded_event)