use "ponygame"

class GridRenderSystem is GameSystem
  var _game: Game
  var _grid_image: I32

  new create(game: Game) =>
    _game = game
    _grid_image = 0
    
    
  fun ref init(): Bool =>
    true
  
  fun ref start(): Bool =>
    // Load grid background.
    _grid_image = _game.resource_manager().load_image("GridBorder.png")
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    _game.renderer().draw_image(_grid_image, 0, 0)
