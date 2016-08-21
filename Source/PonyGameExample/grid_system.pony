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
    let grid_initialized_event = GridInitializedEvent(_grid, _width, _height)
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
    let block = event.entity

    try
      let block_grid_component = _game.entity_manager().get_component[GridComponent](block, "GridComponent")
      let block_image_component = _game.entity_manager().get_component[ImageComponent](block, "ImageComponent")
      let block_image = _game.resource_manager().load_image(block_image_component.image) 
      let game_grid_component = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      // Update grid.
      for x in Range[USize](0, block_grid_component.width()) do
        for y in Range[USize](0, block_grid_component.height()) do
          if block_grid_component.grid(x)(y) > 0 then
            let old_grid_x = x + event.old_x.usize()
            let old_grid_y = y + event.old_y.usize()

            game_grid_component.grid(old_grid_x)(old_grid_y) = 0
          end
        end
      end

      for x in Range[USize](0, block_grid_component.width()) do
        for y in Range[USize](0, block_grid_component.height()) do
          if block_grid_component.grid(x)(y) > 0 then
            let new_grid_x = x + event.new_x.usize()
            let new_grid_y = y + event.new_y.usize()

            game_grid_component.grid(new_grid_x)(new_grid_y) = block_image
          end
        end
      end

      // Check if grounded.
      var grounded: Bool = false

      // Check if reached grid bottom.
      if (block_grid_component.height().i32() + event.new_y) == _height then
        grounded = true
      end

      if not grounded then
        // Check if hit another block.
        for x in Range[USize](0, block_grid_component.width()) do
          if block_grid_component.grid(x)(0) > 0 then
            let grid_x = x + event.new_x.usize()
            let grid_y = block_grid_component.height() + event.new_y.usize()

            try
              if game_grid_component.grid(grid_x)(grid_y) != 0 then
                grounded = true
              end
            end 
          end
        end
      end

      if grounded then 
        _game.logger().log("Block " + block.string() + " grounded.")

        // Notify listeners.
        let block_grounded_event = BlockGroundedEvent(block)
        _game.event_manager().push(block_grounded_event)
      end
    end
