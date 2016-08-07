use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)

class Renderer
  var _initialized: Bool
  
  new create() =>
    _initialized = false
    
  fun ref init(game_name: String, width: I32, height: I32): Bool =>
    if @Initialize(game_name.cstring(), width, height) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      _initialized = true
    end
    
    _initialized
