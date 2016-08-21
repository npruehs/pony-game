use "lib:PonyGameNative"

use "ponygame"

actor Main
  new create(env: Env) =>
    // Create game.
    let game = Game(env)

    // Add systems.    
    game.add_system(SpawnSystem(game))
    game.add_system(FallSystem(game))
    game.add_system(GridSystem(game))
    game.add_system(InputSystem(game))
    game.add_system(ScoreSystem(game))
    game.add_system(GridRenderSystem(game))
    game.add_system(HudSystem(game))
    
    // Start game.
    game.init_and_run()
