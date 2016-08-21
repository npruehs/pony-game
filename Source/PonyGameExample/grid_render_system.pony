use "collections"

use "ponygame"

class GridRenderSystem is GameSystem
  let _tile_size: F32 = 32.0

  var _game: Game
  var _grid_image: I32
  var _grid: U64

  new create(game: Game) =>
    _game = game
    _grid_image = 0
    _grid = 0

    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("GridInitializedEvent", this)

    // Load grid background.
    _grid_image = _game.resource_manager().load_image("GridBorder.png")

    true
  
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    // Draw grid background.
    _game.renderer().draw_image(_grid_image, 0, 0)

    // Draw all blocks.
    try
      let grid = _game.entity_manager().get_component[GridComponent](_grid, "GridComponent")

      for x in Range[USize](0, grid.width()) do
        for y in Range[USize](0, grid.height()) do
          let grid_color = grid.grid(x)(y)

          if grid_color != 0 then
            _game.renderer().draw_image(grid_color, x.f32() * _tile_size, y.f32() * _tile_size)
          end
        end
      end
    end

  fun ref notify(event: GameEvent): None =>
    try
      _on_grid_initialized(event as GridInitializedEvent)
    end

  fun ref _on_grid_initialized(event: GridInitializedEvent): None =>
   _grid = event.entity
