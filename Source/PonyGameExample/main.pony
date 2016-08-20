use "lib:PonyGameNative"

use "ponygame"

actor Main
  new create(env: Env) =>
    let game = Game(env)

    // Create systems.
    var hud_system = HudSystem(game)
    var spawn_system = SpawnSystem(game)
    var block_render_system = BlockRenderSystem(game)
    var fall_system = FallSystem(game)
    var grid_system = GridSystem(game)

    game.add_system(hud_system)
    game.add_system(spawn_system)
    game.add_system(block_render_system)
    game.add_system(fall_system)
    game.add_system(grid_system)
    
    // Initialize game.
    if game.init() then
      var running: Bool = true
      
      // Main loop.
      while running do
        running = game.tick()
      end
    end
