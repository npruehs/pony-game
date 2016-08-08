use "lib:PonyGameNative"

use "ponygame"

actor Main
  new create(env: Env) =>
    let game = Game(env)

    // Create systems.
    var character_system = CharacterSystem(game)
    var hud_system = HudSystem(game)
    
    game.add_system(character_system)
    game.add_system(hud_system)

    // Initialize game.
    if game.init() then
      var running: Bool = true
      
      // Main loop.
      while running do
        running = game.tick()
      end
    end
