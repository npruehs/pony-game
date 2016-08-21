use "lib:PonyGameNative"

use "ponygame"

actor Main
  new create(env: Env) =>
    let game = Game(env)

    // Create systems.    
    var spawn_system = SpawnSystem(game)
    var fall_system = FallSystem(game)
    var grid_system = GridSystem(game)
    var input_system = InputSystem(game)

    var grid_render_system = GridRenderSystem(game)
    var hud_system = HudSystem(game)

    game.add_system(spawn_system)
    game.add_system(fall_system)
    game.add_system(grid_system)
    game.add_system(input_system)

    game.add_system(grid_render_system)
    game.add_system(hud_system)
    
    // Initialize game.
    if game.init() then
      var running: Bool = true
      
      // Main loop.
      while running do
        running = game.tick()
      end
    end
